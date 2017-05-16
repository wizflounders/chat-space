class GroupsController < ApplicationController
  def new
   @group = Group.new
  end

  def create
     group = Group.create(create_params)
  end

  private
  def create_params
    params.require(:chat_group).permit(:name)
  end
end
