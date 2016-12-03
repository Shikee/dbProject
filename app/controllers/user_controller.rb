class UserController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_100, only: [:index]
  before_action :set_five, only: [:index]
  before_action :question_static, only: [:index]

  def index
    @assigns = @user.assigns
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    def set_five
          earray = Array.new
          if @user.aevals.first != nil

            @user.aevals.each do |a|
              earray.push(a.ratepoint)
            end
            @user.qevals.each do |a|
              earray.push(a.ratepoint)
            end
            @fiv_dev = earray.stdev
            @fiv_avr = earray.reduce(:+) / earray.size.to_f
          else
            @fiv_dev = "nil"
            @fiv_avr = "nil"
          end

    end
    def set_100
      harray = Array.new
      if @user.hevals.first != nil
        @user.hevals.each do |a|
          harray.push(a.question1)
          harray.push(a.question2)
        end
        @hun_dev = harray.stdev
        @hun_avr = harray.reduce(:+) / harray.size.to_f
      else
        @hun_dev = "nil"
        @hun_avr = "nil"
      end
    end

    def question_static
      q5array = Array.new
      q1array = Array.new
      if @user.questions.first !=nil
        @user.questions.each do |a|
          if(a.qevals.first != nil)
            a.qevals.each do |b|
              q5array.push(b.ratepoint)
            end
          end
          if a.hevals.first != nil
            a.hevals.each do |c|
              q1array.push(c.question1)
              q1array.push(c.question2)
            end
          end
        end
        if q5array.size > 1
          @q5_avr = q5array.reduce(:+) / q5array.size.to_f
          @q5_dev = q5array.stdev
        else
          @q5_avr = "nil"
          @q5_dev = "nil"

        end
        if q1array.size != 0

          @q1_avr = q1array.reduce(:+) / q1array.size.to_f
          @q1_dev = q1array.stdev
        else
          @q1_avr = "nil"
          @q1_dev = "nil"
        end
      else
        @q1_avr = "nil"
        @q1_dev = "nil"
        @q5_avr = "nil"
        @q5_dev = "nil"
      end

    end
end
