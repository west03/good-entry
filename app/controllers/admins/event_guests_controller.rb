class Admins::EventGuestsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @guest = Guest.find(params[:id])
    @event_entries = @guest.event_entries.page(params[:page]).per(10)
  end
end
