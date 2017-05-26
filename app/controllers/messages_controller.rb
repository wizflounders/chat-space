class MessagesController < ApplicationController
  def index
   @groups = current_user.groups.includes(:messages)
   @group = Group.find(params[:group_id])
   @message = @group.messages.new
   @messages = @group.messages.includes(:user).order(created_at: :DESC)
  end

  def create
    @message = current_user.messages.create(create_params)
    if @message.save
      redirect_to group_messages_path(@message.group), notice: "メッセージ送信成功"
    else
      flash[:alert] = 'メッセージもしくは画像を送信してください'
      redirect_to group_messages_path(@message.group)
    end
  end

  private
  def create_params
    params.require(:message).permit(:body,:image).merge(group_id: params[:group_id])
  end
end
