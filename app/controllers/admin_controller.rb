class AdminController < ApplicationController
  before_filter :authorize_admin
  before_action :set_member, only: [:editmember,:updatemember,:deletemember]

  def category
    @categories = Category.all
  end

  def index
    @users = User.all

    @users.each do |a|
      a.age = Time.now.utc.to_date.year - a.birth.year
      if(a.WorksFor.first != nil)
        a.role = "mentor"
      end
      a.save
    end
    group = Mentorgroup.all
    group.each do |a|
      User.find(a.user_id).update_attributes(role: "super")
    end
  end
  def fusers
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
