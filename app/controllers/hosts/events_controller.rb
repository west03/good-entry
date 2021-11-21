class Hosts::EventsController < ApplicationController
  before_action :authenticate_host!
  before_action :correct_host, only: [:edit]
  def index
    @events = Event.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @event = Event.new
    @genres = current_host.genres
  end

  def create
    @event = current_host.events.new(event_params)
    @genres = current_host.genres
    if params[:event][:name].present?
      tag_list = params[:event][:name].split(',')
      @event.save_event_tag(tag_list)
    end
    if @event.save
      redirect_to hosts_event_posts_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @event_tags = @event.tags
    @comments = @event.comments.page(params[:page]).per(7).reverse_order
  end

  def edit
    @event = Event.find(params[:id])
    @genres = current_host.genres
    @tag_list = @event.tags.pluck(:name).join(',')
  end

  def update
    @event = Event.find(params[:id])
    @genres = current_host.genres
    if params[:event][:name].present?
      tag_list = params[:event][:name].split(',')
      @event.save_event_tag(tag_list)
    end
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

  def search
    if (params[:keyword])[0] == '#'
      @events = Tag.search(params[:keyword]).order('created_at desc').page(params[:page]).per(10)
    else
      @events = Event.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
      @keyword = params[:keyword]
    end
    render :index
  end

  private

  def event_params
    params.require(:event).permit(:host_id, :title, :image, :introduction, :genre_id, :date_and_time, :address,
                                  :prefecture, :holding_flag)
  end

  def correct_host
    @host = Host.find(current_host.id)
    redirect_to hosts_events_path unless @host == current_host
  end
end
