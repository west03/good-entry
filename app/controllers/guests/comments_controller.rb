class Guests::CommentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    comment = current_guest.comments.new(comment_params)
    comment.event_id = event.id
    comment.save
    redirect_to event_path(event)
  end

  def destroy
    Comment.find_by(id: params[:id], event_id: params[:event_id]).destroy
    redirect_to event_path(params[:event_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :event_id, :guest_id)
  end

end
