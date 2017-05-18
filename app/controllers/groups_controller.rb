class GroupsController < ApplicationController
  def new
   @group = Group.new
  end

  def create
    group = Group.create(create_group_params)
    group.save

    # 自身をチェックしていない場合に自身をメンバー追加
    unless group.user_ids.include?(current_user.id)
      group.group_users.create(user_id: current_user.id, group_id: group.id)
    end
    redirect_to :root and return
  end

  private
  def create_group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
