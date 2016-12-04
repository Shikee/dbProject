class AevalsController < ApplicationController
  before_action :set_answer, only: [:create, :destroy, :edit, :check]
  before_action :set_question, only: [:create, :destroy, :edit, :check]
  before_action :set_aeval, only: [:update, :destroy, :edit, :check]
  before_action :set_param, only: [:create]
  before_action :set_up, only: [:update]

  def create

    @aeval = @answer.aevals.new(ratepoint: @avalue, answer_id: @aaid)
    @aeval.user = current_user
    if @aeval.save
      current_user.increment!(:eval_count,1)

      redirect_to category_question_path(@question.category_id,@question.id), notice: '감사합니다 평가하셨습니다!'
    else
      redirect_to category_question_path(@question.category_id,@question.id), alert: '평가에 실패습니다.'
    end
  end

  def update
    para = params.to_unsafe_h()
    @aeval.ratepoint =  para.values[3]
    @aeval.answer_id = params[:answer_id]
    if @aeval.save
      @question= Question.find(params[:question_id])
      redirect_to category_question_path(@question.category_id,@question.id), notice: '평가를 변경하셨습니다!'
    else
      redirect_to category_question_path(@question.category_id,@question.id), alert: '평가에 실패습니다.'
    end
  end

  private
     def set_answer
       @answer= Answer.find(params[:answer_id])
     end
     def set_question
       @question= Question.find(params[:question_id])

     end
     def set_aeval
       @aeval = Aeval.find(params[:id])
     end
     def set_param
      @avalue = params.values[2]
      @aqid = params.values[4]
      @aaid = params.values[5]
      puts "receive #{@avalue.to_i}"
      puts "receive #{@aaid.to_i}"
     end
     def set_up
       @ratepoint = params[:commit]
     end
end
