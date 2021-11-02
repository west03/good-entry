class Hosts::EventsController < ApplicationController
  def index
    @events = Event.all.page(params[:page]).per(10)
  end

  def new
    @event = Event.new
    @genres = current_host.genres
  end

  def create
    @event = Event.new(event_params)
    @genre = current_host.genres
    if @event.save
      redirect_to hosts_event_posts_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def event_params
    params.require(:event).permit(:host_id, :title, :image, :introduction, :genre_id, :date_and_time)
  end
end
