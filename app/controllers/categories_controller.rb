class CategoriesController < ApplicationController
    def show
        puts  params[:id]
        @questions = Question.where(category_id: params[:id])
    end
    def new
      @category= Category.new
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
      @category.delete
      redirect_to admin_category_path
    end
    private
      def category_params
        params.require(:category).permit(:name)
      end
end
