class Admins::EventEntriesController < ApplicationController
    before_action :authenticate_admin!
  def show
    @event = Event.find(params[:id])
    @guests = @event.event_entries.page(params[:page]).per(10)
  end

end
