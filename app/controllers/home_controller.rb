class HomeController < ApplicationController
  def index
      @categories = Category.all
      @notices = Notice.all
  end
end
