class Admins::EventGuestsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @guest = Guest.find(params[:id])
    event_array = @guest.event_entries.pluck(:event_id)
    p_event = Event.find(event_array)
    @event_entries = Kaminari.paginate_array(p_event).page(params[:page]).per(10)
  end

  def search
    @guest = Guest.find(params[:event_guest_id])
    event_array = @guest.event_entries.pluck(:event_id)
    event_srch = Event.find(event_array)
    event_entries = []
    event_srch.each do |ee|
      event_entries << ee if ee.title.match(/#{params[:keyword]}/)
    end
    @event_entries = Kaminari.paginate_array(event_entries).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
  end
end
