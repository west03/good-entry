class Guests::HostsController < ApplicationController
  before_action :authenticate_guest!
  def index
    @hosts = Host.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @host = Host.find(params[:id])
  end

  def search
    @hosts = Host.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :index
  end
end
