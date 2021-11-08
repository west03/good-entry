class Admins::EventsController < ApplicationController
   before_action :authenticate_admin!
  def index
    @events = Event.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
    @genres = @event.host.genres
  end

  def update
    @event = Event.find(params[:id])
    @genres = @event.host.genres
    if @event.update(event_params)
      redirect_to admins_event_path(@event.id)
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :image, :introduction, :genre_id, :date_and_time, :address, :prefecture, :holding_flag)
  end

end
