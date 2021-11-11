class Guests::EventPostsController < ApplicationController
  def show
  @host = Host.find(params[:id])
  @hosts = @host.events.page(params[:page]).per(10)
  end
end
