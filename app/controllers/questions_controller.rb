class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :check, only: [:index]

  before_action :can_qeval, only: [:show, :edit, :update, :destroy]
  before_action :set_qeval, only: [:show]
  before_action :set_qeval_info, only: [:show]
  before_action :set_category, only: [:show]
  before_action :get_attachment, only: [:show]


  # GET /questions
  # GET /questions.json
  # def index
  #   @questions = Question.all
  # end

  # GET /questions/1
  # GET /questions/1.json
  def index
    question = Question.all
    if user_signed_in?
      question.each do |a|
        current_user.assigns.each do |b|
          if b.question_id == a.id
            a.update_attributes(assign: 1)
          end
        end
      end
    end
    if @is_mentor == false
      if params[:sort] =="qpoint1"
        @questions = Question.sorted_by_qpoint
      elsif params[:sort] == "qpoint2"
        @questions = Question.sorted_by_qpoint2

      elsif params[:sort] =="category_name"
        @questions = Question.sorted_by_category_name
      elsif params[:sort] =="caneval"
        @questions = Question.sorted_by_caneval
      elsif params[:sort] =="created_at"
        @questions = Question.order('created_at ASC' )
      else
        @questions = Question.order(params[:sort])

      end
    end
    if params[:sort] =="qpoint1"
      @questions = Question.sorted_by_qpoint
    elsif params[:sort] =="qpoint2"
      @questions = Question.sorted_by_qpoint2
    elsif params[:sort] =="category_name"
      @questions = Question.sorted_by_category_name
    elsif params[:sort] =="caneval"
      @questions = Question.sorted_by_caneval
    elsif params[:sort] == "created_at"
      @questions = Question.order("created_at DESC").all
    elsif params[:sort] == "assign"
      @questions = Question.order("assign DESC").all
    else
      @questions = Question.order(params[:sort])
    end

  end




  def show
    @is_mentor = false
    @is_super = false
    if(current_user !=nil)
      current_user.WorksFor.each do |a|
        if(  Mentorgroup.find(a.mentorgroup_id).category_id.to_i == params[:category_id].to_i)
          @is_mentor = true
        end
      end
      mentorgroups = Mentorgroup.where(category_id: params[:category_id])
      mentorgroups.each do |a|
        if(a.user_id.to_i == current_user.id.to_i)
          @is_super = true
        end
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
        current_user.increment!(:question_count,1)
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
    id = @question.category_id
    @question.destroy
    current_user.decrement!(:question_count,1)

      redirect_to category_path(id), notice: 'Question was successfully destroyed.'

  end

  def aq
    mentorgroups = Mentorgroup.where(category_id: params[:category_id]).where(user_id: current_user.id)
    @question = Question.find(params[:question_id])
    @mt = mentorgroups.first.id
    @user = Mentorgroup.find(@mt).WorksFor
    @assign = Assign.where(question_id: params[:question_id]).where(mentorgroup_id: @mt)
  end
  def adminaq
    @mentorgroups = Mentorgroup.where(category_id: params[:category_id])
    @question = Question.find(params[:question_id])
    @assign = Assign.where(question_id: params[:question_id])
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end
    def set_category
      @category = @question.category
    end
    def set_qeval
      if user_signed_in?
        @qeval = current_user.qevals.where(question_id: @question.id).first
      end
    end

    def set_qeval_info
      @qeval_avr = @question.qevals.average("ratepoint")
      q5array = Array.new
      if(@question.qevals.first != nil)
        @question.qevals.each do |b|
          q5array.push(b.ratepoint)
        end
        if(q5array.size>=2)
          @qeval_dev = q5array.stdev
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title,:content)
    end
    def can_qeval
      @can_qeval = (@question.created_at + 60*60*24) > Time.now
    end
  
    def get_attachment
      @semi  = @question.content[/\">.*/]
      if(@semi == nil)
        @semi = false
      else
        @semi.slice!("\">")
        @attachment = @semi.slice(0..(@semi.index("</a>")))
        puts @attachment
        index = @attachment.size
        @attachment.slice!(index-1)
        @semi = true
      end
    end




    def check
      @is_mentor = false
      @is_super = false
      if(current_user !=nil)
        if current_user.WorksFor.first != nil
          @is_mentor = true
        end
        mentorgroups = Mentorgroup.all
        mentorgroups.each do |a|
          if(a.user_id.to_i == current_user.id.to_i)
            @is_super = true
          end
        end
      end
    end

end
