class Guests::EventEntriesController < ApplicationController
  def index
    @event_entries = EventEntry.all
  end

  def create
    @event_entry = current_guest.event_entries.new(event_entry_params)
    #if current_guest.event_entries.find_by(event_id: params[:event_entries][:event_id])
    if
    @event_entry = current_guest.event_entries.new(event_entry_params)
    @event_entry.save
    redirect_to event_entries_path
    else
      render :events/show
    end
  end

  def update; end

  def destroy; end

  def destroy_all; end

  private

  def event_entry_params
    params.require(:event_entry).permit(:guest_id)
  end

end
