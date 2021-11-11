class Guests::LikesController < ApplicationController
  def create
    @like = current_guest.likes.create(event_id: params[:event_id])
    @event = Event.find(params[:event_id])
  end

  def destroy
    @like = Like.find_by(event_id: params[:event_id], guest_id: current_guest.id)
    @like.destroy
    @event = Event.find(params[:event_id])
  end
end
