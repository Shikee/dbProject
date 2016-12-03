class QevalsController < ApplicationController
  before_action :set_question, only: [:create, :update, :destroy, :edit, :check]
  before_action :set_qeval, only: [:update, :destroy, :edit, :check]
  def create
    @qeval = @question.qevals.new(qeval_params)
    @qeval.user = current_user
    if @qeval.save
      current_user.increment!(:eval_count,1)

      redirect_to category_question_path(@question.category_id,@question.id), notice: '감사합니다 평가하셨습니다!'
    else
      redirect_to category_question_path(@question.category_id,@question.id), alert: '평가에 실패습니다.'
    end
  end

  def update
    if @qeval.update(qeval_params)
      redirect_to category_question_path(@question.category_id,@question.id), notice: '평가를 변경하셨습니다!'
    else
      redirect_to category_question_path(@question.category_id,@question.id), alert: '평가에 실패습니다.'
    end
  end

  private
     def set_question
       @question = Question.find(params[:question_id])
     end
     def set_qeval
       @qeval = Qeval.find(params[:id])
     end
     def qeval_params
       params.require(:qeval).permit(:ratepoint)
     end
end
