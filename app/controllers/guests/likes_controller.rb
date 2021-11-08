class Guests::LikesController < ApplicationController
  def create
    @like = current_guest.likes.create(event_id: params[:event_id])
    redirect_back(fallback_location: events_path)
  end

  def destroy
    @like = Like.find_by(event_id: params[:event_id], guest_id: current_guest.id)
    @like.destroy
    redirect_back(fallback_location: events_path)
  end
end
