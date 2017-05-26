class MessagesController < ApplicationController
  def index
   @groups = current_user.groups
  end

  def create
    @message = current_user.messages.create(create_params)
    if @message.save
      redirect_to group_path(@message.group), notice: "メッセージ送信成功"
    else
      redirect_to group_path(@message.group), alert: "メッセージを入力してください"
    end
  end

  private
  def create_params
    params.require(:message).permit(:body, :group_id)
  end
end
