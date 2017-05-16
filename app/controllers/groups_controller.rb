class GroupsController < ApplicationController
  def new
   @group = Group.new
  end

  def create
    group = Group.create(create_params)
    group.group_users.create(user_id: current_user.id, group_id: group.id)

    redirect_to :root and return
  end

  private
  def create_params
    params.require(:group).permit(:name)
  end
end
