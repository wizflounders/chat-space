class MessagesController < ApplicationController
  def index
   @groups = current_user.groups
  end

  def create

    Message.create(create_params)
    redirect_to :root
  end

  private
  def create_params
    params.require(:message).permit(:body, :group_id).merge(user_id: current_user.id)
  end
end
