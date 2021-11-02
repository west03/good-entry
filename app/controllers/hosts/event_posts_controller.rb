class Hosts::EventPostsController < ApplicationController
  def index
    @events = current_host.events.page(params[:page]).per(10)
  end
end
