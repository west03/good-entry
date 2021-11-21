class Guests::EventsController < ApplicationController
  before_action :authenticate_guest!
  def index
    @events = Event.all.order(created_at: :desc).page(params[:page]).per(10)
    @like = Like.new
  end

  def show
    @event = Event.find(params[:id])
    @event_entry = EventEntry.new
    @like = Like.new
    @comment = Comment.new
    @comments = @event.comments.page(params[:page]).per(7).reverse_order
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
end
