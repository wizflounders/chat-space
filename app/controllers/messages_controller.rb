class MessagesController < ApplicationController
  def index
   @groups = current_user.groups
  end

  def create
    current_user.messages.create(create_params)
    redirect_to group_path(id: params[:message][:group_id])
  end

  private
  def create_params
    params.require(:message).permit(:body, :group_id)
  end
end
