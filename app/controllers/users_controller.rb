class UsersController < ApplicationController
  def edit

  end

  def update
    current_user.update(update_params)
    redirect_to :root, notice: "アカウントが更新されました"
  end

  def index
    @users = User.all
   respond_to do |format|
     format.html { redirect_to new_group_path }
     format.json
   end
 end

  private

  def update_params
    params.require(:user).permit(:name, :email)
  end
end
