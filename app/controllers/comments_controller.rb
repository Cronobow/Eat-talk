class CommentsController < ApplicationController
  before_action :set_restaurant


  def create
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.is_admin?
      @comment.destroy
      flash[:notice] = "Comment successfully deleted"
    end
    redirect_to restaurant_path(@restaurant)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
