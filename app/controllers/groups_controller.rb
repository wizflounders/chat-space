class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update]
  def index
    @groups = current_user.groups.includes(:messages)
  end
  def new
   @group = Group.new
  end

  def create
    @group = Group.new(create_group_params)
    # 自身をチェックしていない場合に自身をメンバー追加
    unless @group.user_ids.include?(current_user.id)
      @group.group_users.new(user_id: current_user.id, group_id: @group.id)
    end

    @group.save
    if @group.save
      redirect_to group_messages_path(@group.id), notice: "グループが作成されました！"
    else
      render 'new'
    end
  end

  def edit

  end

  def update
     @group.update(update_params)
     #自身が含まれていない時に自身をメンバーに追加
     unless @group.user_ids.include?(current_user.id)
       @group.group_users.new(user_id: current_user.id, group_id: @group.id)
     end
     if @group.save
       redirect_to group_messages_path(@group.id), notice: "グループ情報が更新されました"
     else
       render 'edit'
     end
  end

  private
  def create_group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def update_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
