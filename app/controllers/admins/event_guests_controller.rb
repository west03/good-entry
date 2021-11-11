class Admins::EventGuestsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @guest = Guest.find(params[:id])
    @event_entries = @guest.event_entries.page(params[:page]).per(10)
  end

  def search
    # binding.irb
    # @event_entries = current_guest.event_entries.events.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @guest = Guest.find(params[:id])

    event_entries = []
    @guest.event_entries.each do |ee|
      if ee.event.title.match(/#{params[:keyword]}/)
        event_entries << ee
      end
    end

    @event_entries = Kaminari.paginate_array(event_entries).page(params[:page]).per(1)

    @keyword = params[:keyword]
    render :show
  end

end
