class Dark::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin


  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Successfully created"
      redirect_to dark_categories_path
    else
      @categories = Category.all
      flash.now[:alert] = @category.errors.full_messages.to_sentence if @category.errors.any?
      render :index
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:alert] = "category was successfully deleted"
    redirect_to dark_categories_path
  end



  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
