class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :is_current_user?, except: [:index, :show]

  def index
    @users = User.all
  end

  def show
    @commented_restaurants = @user.restaurants.uniq
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Successfully updated"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence if @user.errors.any?
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def is_current_user?
    if @user != current_user
      flash[:alert] = "No permission !"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :intro)
  end

end
