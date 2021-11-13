class Guests::EventEntriesController < ApplicationController
  def index
    @event_entries = current_guest.event_entries.page(params[:page]).per(10)
  end

  def create
    @event_entry = EventEntry.find_or_initialize_by(guest_id: current_guest.id, event_id: params[:event_entry][:event_id])
    @event_entry.save
    redirect_to event_entries_path
  end

  def destroy
    @event_entry = current_guest.event_entries.find(params[:id])
    @event_entry.destroy
    redirect_to event_entries_path
  end

  def destroy_all
    @event_entries = current_guest.event_entries.all
    @event_entries.destroy_all
     redirect_to event_entries_path
  end

  def search
    event_entries = []
    current_guest.event_entries.each do |ee|
      if ee.event.title.match(/#{params[:keyword]}/)
        event_entries << ee
      end
    end
    @event_entries = Kaminari.paginate_array(event_entries).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :index
  end

  private

  def event_entry_params
    params.require(:event_entry).permit(:guest_id, :event_id)
  end

end
