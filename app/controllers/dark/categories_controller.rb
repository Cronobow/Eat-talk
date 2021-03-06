class Dark::CategoriesController < Dark::BaseController
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all

    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
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

  def update
    if @category.update(category_params)
      flash[:notice] = "Successfully updated"
      redirect_to dark_categories_path
    else
      @categories = Category.all
      flash.now[:alert] = @category.errors.full_messages.to_sentence if @category.errors.any?
      render :index
    end
  end

  def destroy
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
