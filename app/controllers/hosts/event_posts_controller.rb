class Hosts::EventPostsController < ApplicationController
  def index
    @events = current_host.events.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
  end
end
