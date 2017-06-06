class MessagesController < ApplicationController
  before_action :set_group, :set_message
  def index

  end

  def create
    @message = current_user.messages.new(create_params)
    respond_to do |format|
    if @message.save
      format.html {redirect_to group_messages_path(@message.group), notice: "メッセージ送信成功"}
      format.json

    else
        flash.now[:alert] = 'メッセージもしくは画像を送信してください'
        render 'index'
    end
  end
  end

  private
  def create_params
    params.require(:message).permit(:body,:image).merge(group_id: params[:group_id])
  end

  def set_group
    @groups = current_user.groups.includes(:messages)
    @group = Group.find(params[:group_id])
  end

  def set_message
    @message = @group.messages.new
    @messages = @group.messages.includes(:user).order(created_at: :DESC)
  end
end
