class Guests::EventsController < ApplicationController
  def index
    @events = Event.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @event = Event.find(params[:id])
    @event_entry = EventEntry.new
  end
end
