class UsersController < ApplicationController
  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to :root
    else
      render :edit
    end
  end

  private
  def users_params
    params.require(:users).permit(:name, :email)
  end
end
