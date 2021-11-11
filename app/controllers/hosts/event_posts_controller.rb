class Hosts::EventPostsController < ApplicationController
  def index
    @events = current_host.events.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
  end

  def search
    @events = current_host.events.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :index
  end
end
