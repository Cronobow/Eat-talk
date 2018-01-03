class Dark::RestaurantsController < Dark::BaseController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "Successfully created"
      redirect_to dark_restaurants_path
    else
      flash.now[:alert] = "Failed to Create"
      render :new
    end
  end

  def edit

  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "Successfully updated"
      redirect_to dark_restaurant_path(@restaurant)
    else
      flash.now[:alert] = "Failed to update"
      render :edit
    end
  end

  def show

  end

  def destroy
    @restaurant.destroy
    redirect_to dark_restaurants_path
    flash[:notice] = "Successfully deleted"
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :category_id, :opening_hours, :tel, :address, :description, :image)
  end

end
