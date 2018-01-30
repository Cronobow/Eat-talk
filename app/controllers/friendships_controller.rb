class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friending_id: params[:friending_id])

    if @friendship.save
      flash[:notice] = "Successfully add friendship"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence if @friendship.errors.any?
    end

    redirect_back(fallback_location: users_path)
  end

  def destroy
    @friendship = current_user.friendships.where(friending_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "Friendship destroyed"
    redirect_back(fallback_location: users_path)
  end

end
