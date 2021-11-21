class Admins::EventEntriesController < ApplicationController
  before_action :authenticate_admin!
  def show
    @event = Event.find(params[:id])
    guest_array = @event.event_entries.pluck(:guest_id)
    p_guests = Guest.find(guest_array)
    @event_entries = Kaminari.paginate_array(p_guests).page(params[:page]).per(10)
  end

  def search
    @event = Event.find(params[:event_entry_id])
    @event_entries = @event.event_entries
    @event_entries = Guest.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
  end
end
