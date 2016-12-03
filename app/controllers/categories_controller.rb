class CategoriesController < ApplicationController
  before_action :check, only: [:show]

    def show
        puts  params[:id]
        @questions = Question.where(category_id: params[:id])
        @category = Category.find(params[:id])
    end
    def new
      @category= Category.new
    end
    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])

      @category.update(category_params)
      redirect_to admin_category_path, notice: 'category was successfully edited.'
    end
    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to admin_category_path, notice: 'category was successfully created.'
      else
        redirect_to admin_category_path, alert: '카테고리가 저장되지 않았습니다.'
      end
    end
    def destroy
      @category = Category.find(params[:id])
      @category.destroy
      redirect_to admin_category_path
    end
    private
      def category_params
        params.require(:category).permit(:name)
      end
      def check
        @is_mentor = false
        @is_super = false
        if(current_user !=nil)
          if current_user.WorksFor.first != nil
            current_user.WorksFor.each do |a|
              if Mentorgroup.find(a.mentorgroup_id).category_id.to_i == params[:id].to_i
                @is_mentor = true
              end
            end
          end
          mentorgroups = Mentorgroup.where(category_id: params[:id])
          mentorgroups.each do |a|
            if a.user_id == current_user.id

              @is_super = true
            end
            puts @is_super
          end
        end
      end
end
