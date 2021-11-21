class Admins::EventsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @events = Event.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
    @comments = @event.comments.page(params[:page]).per(7).reverse_order
  end

  def edit
    @event = Event.find(params[:id])
    @genres = @event.host.genres
    @tag_list = @event.tags.pluck(:name).join(',')
  end

  def update
    @event = Event.find(params[:id])
    @genres = @event.host.genres
    if params[:event][:name].present?
      tag_list = params[:event][:name].split(',')
      @event.save_event_tag(tag_list)
    end
    if @event.update(event_params)
      redirect_to admins_event_path(@event.id)
    else
      render :edit
    end
  end

  def destroy
    Event.destroy(params[:id])
    redirect_to admins_events_path
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
    params.require(:event).permit(:title, :image, :introduction, :genre_id, :date_and_time, :address, :prefecture,
                                  :holding_flag)
  end
end
