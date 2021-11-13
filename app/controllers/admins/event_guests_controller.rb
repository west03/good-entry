class Admins::EventGuestsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @guest = Guest.find(params[:id])
    @event_entries = @guest.event_entries.page(params[:page]).per(10)
  end

  def search
    @guest = Guest.find(params[:event_guest_id])
    event_entries = []
    @guest.event_entries.each do |ee|
      if ee.event.title.match(/#{params[:keyword]}/)
        event_entries << ee
      end
    end
    @event_entries = Kaminari.paginate_array(event_entries).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
  end

end
