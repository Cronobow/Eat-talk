class RestaurantsController < ApplicationController

    def index
      @restaurants = Restaurant.all.page(params[:page]).per(9)
    end

end
