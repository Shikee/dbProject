class MentorgroupsController < ApplicationController
  before_action :set_mentorgroup, only: [:show, :edit, :update, :destroy, :setsuper,:updatesuper,:editmember,:updatemember]

  # GET /mentorgroups
  # GET /mentorgroups.json
  def index
    @mentorgroups = Mentorgroup.all
  end

  # GET /mentorgroups/1
  # GET /mentorgroups/1.json
  def show
    @super = @mentorgroup.user
    @members = WorksFor.where(mentorgroup_id: @mentorgroup.id)

  end

  # GET /mentorgroups/new
  def new
    @mentorgroup = Mentorgroup.new
    @categories = Category.all
  end

  # GET /mentorgroups/1/edit
  def edit
  end



  # POST /mentorgroups
  # POST /mentorgroups.json
  def create
    @mentorgroup = Mentorgroup.new(mentorgroup_params)

      if @mentorgroup.save
        redirect_to mentorgroups_path, notice: 'Mentorgroup was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /mentorgroups/1
  # PATCH/PUT /mentorgroups/1.json
  def update
      if @mentorgroup.update(mentorgroup_params)
        redirect_to @mentorgroup, notice: 'Mentorgroup was successfully updated.'
      else
        render :edit
      end

  end

  # DELETE /mentorgroups/1
  # DELETE /mentorgroups/1.json
  def destroy
    @mentorgroup.destroy
    redirect_to mentorgroups_url, notice: 'Mentorgroup was successfully destroyed.'
  end

  def setsuper
    @user = User.all
    if(Mentorgroup.find(params[:id]).user != nil)
      @current_super = Mentorgroup.find(params[:id]).user
    else
      @current_super = "now empty"
    end
  end
  def updatesuper
    if @mentorgroup.update(supermentor_params)
      redirect_to @mentorgroup, notice: 'Super mentor was successfully updated.'
    else
      render :setsuper
    end
  end
  def destroysuper

    @super = Mentorgroup.find(params[:id])
    @super.update_attributes(user_id: nil)
    redirect_to  setsuper_mentorgroup_url, notice: 'SuperMentor was successfully destroyed.'
  end

  def editmember
    @user = User.all
    @members = WorksFor.where(mentorgroup_id: @mentorgroup.id)
    @workfor = WorksFor.new
  end

  def updatemember

    @workfor = WorksFor.new
    @workfor.user_id = params[:works_for][:user_id]
    @workfor.mentorgroup_id= params[:works_for][:mentorgroup_id]
    @workfor.category_id = Mentorgroup.find(params[:works_for][:mentorgroup_id]).category_id
    if @workfor.save
      redirect_to editmember_mentorgroup_path, notice: 'Member was successfully joined.'
    else
      redirect_to editmember_mentorgroup_path, notice: 'WARNING: Member was not successfully joined.'
    end
  end

  def destroymember

    @workfor = WorksFor.find(params[:id])
    @workfor.destroy
    redirect_to mentorgroups_url, notice: 'Member was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mentorgroup
      @mentorgroup = Mentorgroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mentorgroup_params
      params.require(:mentorgroup).permit(:name, :category_id,:user_id)
    end
    def worksfor_params
      params.require(:WorksFor).permit(:user_id, :mentorgroup_id)
    end
    def supermentor_params
      params.require(:mentorgroup).permit(:user_id)
    end
end
