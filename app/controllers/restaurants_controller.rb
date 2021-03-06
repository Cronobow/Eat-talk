class RestaurantsController < ApplicationController
  before_action :set_restaurant, except: [:index, :feeds, :ranking]

  def index
    @restaurants = Restaurant.all.page(params[:page]).per(9)
    @categories = Category.all
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def ranking
    @top_restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

  def show
    @comment = Comment.new
  end

  def dashboard
  end

  def favorite
    Favorite.create(restaurant: @restaurant, user: current_user)
    @restaurant.update_favorites
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.destroy_all
    @restaurant.update_favorites
    redirect_back(fallback_location: root_path)
  end

  def like
    Like.create(restaurant: @restaurant, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = Like.where(restaurant: @restaurant, user: current_user)
    like.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
