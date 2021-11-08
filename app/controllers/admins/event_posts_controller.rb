class Admins::EventPostsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @host = Host.find(params[:id])
    @events = @host.events.page(params[:page]).per(10)
  end
end
