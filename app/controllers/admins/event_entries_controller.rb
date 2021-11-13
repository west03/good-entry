class Admins::EventEntriesController < ApplicationController
    before_action :authenticate_admin!
  def show
    @event = Event.find(params[:id])
    @guests = @event.event_entries.page(params[:page]).per(10)
  end

   def search
    entry_guest =[]
    @event = Event.find(params[:event_entry_id])
    @event.event_entries.guests.last_neame.zip(@event.event_entries.guest.last_neame) do |last_name, first_name|
      if last_name||first_name.match(/#{params[:keyword]}/)
        entry_guest << last_name||first_name
      end
    end
    @guests = Kaminari.paginate_array(entry_guest).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
   end

end
