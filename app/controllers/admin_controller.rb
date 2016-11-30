class AdminController < ApplicationController
  before_filter :authorize_admin
  def category
    @categories = Category.all
  end

  def index
  end
end
