class HomesController < ApplicationController
  def top
    @event = Event.all.order(created_at: :desc)
  end
end
