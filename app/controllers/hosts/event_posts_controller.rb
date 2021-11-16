class Hosts::EventPostsController < ApplicationController
  def index
    @events = current_host.events.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
    guest_array = @event.event_entries.pluck(:guest_id)
    p_guests = Guest.find(guest_array)
    @event_entries = Kaminari.paginate_array(p_guests).page(params[:page]).per(10)
  end

  def search
    if (params[:keyword])[0] == '#'
      @events = Tag.search(params[:keyword]).order('created_at desc').page(params[:page]).per(10)
    else
      @events = current_host.events.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
      @keyword = params[:keyword]
    end
    render :index
  end

  def guest_search
    @event = Event.find(params[:event_post_id])
    @event_entries = @event.event_entries
    @event_entries = Guest.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
  end
end
