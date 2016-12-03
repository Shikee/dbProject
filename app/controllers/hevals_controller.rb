class HevalsController < ApplicationController
  before_action :set_heval, only: [:show, :edit, :update, :destroy]
  before_action :set_question, only: [:create, :update, :destroy, :edit, :check]

  # GET /hevals
  # GET /hevals.json
  def index
    @hevals = Heval.all
  end

  # GET /hevals/1
  # GET /hevals/1.json
  def show
  end

  # GET /hevals/new
  def new
    @heval = Heval.new
  end

  # GET /hevals/1/edit
  def edit
  end

  # POST /hevals
  # POST /hevals.json
  def create
    @heval = Heval.new(heval_params)
    @heval.user = current_user
    @heval.question = @question
      if @heval.save
        current_user.increment!(:heval_count,1)
        redirect_to category_question_path(@question.category_id,@question.id), notice: 'Answer was successfully created.'
      else
        redirect_to category_question_path(@question.category_id,@question.id), notice: 'Answer was successfully created.'
      end
  end

  # PATCH/PUT /hevals/1
  # PATCH/PUT /hevals/1.json
  def update
      if @heval.update(heval_params)
        redirect_to @heval, notice: 'Heval was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /hevals/1
  # DELETE /hevals/1.json
  def destroy
    @heval.destroy
    current_user.decrement!(:heval_count,1)

      redirect_to hevals_url, notice: 'Heval was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heval
      @heval = Heval.find(params[:id])
    end
    def set_question
      @question = Question.find(params[:question_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heval_params
      params.require(:heval).permit(:question1,:question2,:question3)
    end
    def answer_params
    end
end
