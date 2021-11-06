class Hosts::EventsController < ApplicationController
  before_action :correct_host, only:[:edit]
  def index
    @events = Event.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @event = Event.new
    @genres = current_host.genres
  end

  def create
    @event = Event.new(event_params)
    @genres = current_host.genres
    if @event.save
      redirect_to hosts_event_posts_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
    @genres = current_host.genres
  end

  def update
    @event = Event.find(params[:id])
    @genres = current_host.genres
    if @event.update(event_params)
      redirect_to hosts_event_path(@event.id)
    else
      render :edit
    end
  end

  def destroy
    Event.destroy(params[:id])
    redirect_to hosts_event_posts_path
  end

  private

  def event_params
    params.require(:event).permit(:host_id, :title, :image, :introduction, :genre_id, :date_and_time, :address, :prefecture, :holding_flag)
  end

  def correct_host
    @host = Host.find(current_host.id)
    unless @host == current_host
      redirect_to hosts_events_path
    end
  end

end
