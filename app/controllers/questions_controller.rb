class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  # GET /questions
  # GET /questions.json
  # def index
  #   @questions = Question.all
  # end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @is_mentor = false
    current_user.WorksFor.each do |a|
      if(  Mentorgroup.find(a.mentorgroup_id).category_id.to_i == params[:category_id].to_i)
        @is_mentor = true
      end
    end

  end

  # GET /questions/new
  def new
    @category = Category.find_by_id(params[:category_id])
    @question = @category.questions.build

  end
  # GET /questions/1/edit
  def edit
      puts params.inspect
  end

  # POST /questions
  # POST /questions.json
  def create
    @category = Category.find_by_id(params[:category_id])
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.category_id = params[:category_id]
      if @question.save
        redirect_to category_question_path(params[:category_id],@question.id), notice: 'Question was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
      if @question.update(question_params)
        redirect_to category_question_path(params[:category_id],@question.id), notice: 'Question was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      redirect_to questions_url, notice: 'Question was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title,:content)
    end
end
