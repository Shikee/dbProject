class AdminController < ApplicationController
  before_filter :authorize_admin
  before_action :set_member, only: [:editmember,:updatemember,:deletemember]

  def category
    @categories = Category.all
  end

  def index
  end
  def users
    @users = User.all
  end
  def editmember

  end
  def updatemember
    if @user.update(user_params)
      redirect_to user_path, notice: 'User was successfully updated.'
    else
    end

  end
  def deletemember
      @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end
  private
    def set_member
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:email, :name,:nickname,:birth)
    end
end
