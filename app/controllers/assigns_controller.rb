class AssignsController < ApplicationController
  before_action :set_assign, only: [:show, :edit, :update, :destroy]
  before_action :set_question, only: [:create,:destroy]

  def create
    puts params[:assign]

    @assign = Assign.new
    @assign.question_id = params[:question_id]
    @assign.user_id = params[:assign][:user_id]
    @assign.mentorgroup_id = params[:assign][:mentorgroup_id]
    if @assign.save
      redirect_to category_question_path(@question.category_id,@question.id), notice: 'Assign was successfully created.'
    else
      redirect_to category_question_path(@question.category_id,@question.id), alert: 'Assign이 저장되지 않았습니다.'
    end
  end

  def destroy
    @assign.destroy
    redirect_to category_question_path(@question.category_id,@question.id), notice: ' 삭제되었습니다.'  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assign
      @assign = Assign.find(params[:id])
    end
    def set_question
      @question = Question.find(params[:question_id])
    end
    def assign_params
      params.require(:assign).permit(:title,:content)
    end

end
