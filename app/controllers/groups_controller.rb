class GroupsController < ApplicationController
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
      redirect_to :root , notice: "グループが作成されました！"
    else
      render 'new'
    end
  end

  def show
    @groups = current_user.groups
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
     @group = Group.find(params[:id])
     @group.update(update_params)
     if @group.save
       redirect_to({ action: :show }, notice: "グループ情報が更新されました")

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

end
