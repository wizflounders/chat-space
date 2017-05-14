class UsersController < ApplicationController
  def edit

  end

  def update
    current_user.update(update_params)
    redirect_to :root
  end

  private

  def update_params
    params.require(:user).permit(:name, :email)
  end
end
