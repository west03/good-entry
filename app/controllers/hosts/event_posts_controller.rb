class Hosts::EventPostsController < ApplicationController
  before_action :authenticate_host!
  def index
    @events = current_host.events.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @host = Host.find(params[:id])
    @hosts = @host.events.order(created_at: :desc).page(params[:page]).per(10)
  end

  def search
    if (params[:keyword])[0] == '#'
      @events = Tag.search(params[:keyword]).where(host_id: current_host.id).order('created_at desc').page(params[:page]).per(10)
    else
      @events = current_host.events.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
      @keyword = params[:keyword]
    end
    render :index
  end

  def event_search
    @host = Host.find(params[:event_post_id])
    events = []
    @host.events.reverse.each do |ee|
      events << ee if ee.title.match(/#{params[:keyword]}/)
    end
    @hosts = Kaminari.paginate_array(events).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
  end
end
