class AnswersController < ApplicationController
  before_action :set_question, only: [:create, :update, :destroy, :edit, :check]
  before_action :set_answer, only: [:update, :destroy, :edit, :check]
  before_action :check_user, only:[:edit, :update, :destroy]

 def create
   @answer = @question.answers.new(answer_params)
   @answer.user = current_user

   if @answer.save
     current_user.increment!(:answer_count,1)

     redirect_to category_question_path(@question.category_id,@question.id), notice: 'Answer was successfully created.'
   else
     redirect_to category_question_path(@question.category_id,@question.id), alert: '답변이 저장되지 않았습니다.'
   end
 end

 def update
   if @answer.update(answer_params)
     redirect_to category_question_path(@question.category_id,@question.id), notice: '답변이 성공적으로 수정되었습니다.'
   else
     redirect_to category_question_path(@question.category_id,@question.id), notice: '답변이 수정되지 않았습니다.'
   end
 end

 # def check
 #   if @answer.toggle(current_user.id)
 #     render json: {target: "#answer-#{@answer.id}-checked"}
 #   else
 #     render js: "alert('답변을 선택하실 수 없습니다')"
 #   end
 # end

 def edit
 end

 def destroy
   @answer.destroy
   current_user.decrement!(:answer_count,1)

   redirect_to category_question_path(@question.category_id,@question.id), notice: '답변이 삭제되었습니다.'
 end

 private
   def check_user
     redirect_to :back if @answer.user_id != current_user.id && !(current_user.admin?)
   end

   def set_question
     @question = Question.find(params[:question_id])
   end

   def set_answer
     @answer = Answer.find(params[:id])
   end

   def answer_params
     params.require(:answer).permit(:content, :user_id, :question_id)
   end
end
