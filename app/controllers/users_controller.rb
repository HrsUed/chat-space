class UsersController < ApplicationController

  def index
    @users = User.where("name LIKE(?)", "%#{params[:keyword]}%").limit(20)

    respond_to do |format|
      format.html
      format.json
    end

  end


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
