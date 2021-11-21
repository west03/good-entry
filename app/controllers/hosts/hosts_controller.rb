class Hosts::HostsController < ApplicationController
  before_action :authenticate_host!
  before_action :correct_host, only: %i[edit update]
  def index
    @hosts = Host.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @host = Host.find(params[:id])
  end

  def edit
    @host = current_host
  end

  def update
    @host = Host.find(current_host.id)
    if @host.update(host_params)
      redirect_to hosts_host_path(current_host.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @host = Host.find(current_host.id)
  end

  def withdraw
    @host = Host.find(current_host.id)
    @host.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def search
    @hosts = Host.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :index
  end

  private

  def host_params
    params.require(:host).permit(:name, :postal_code, :address, :telephone_number, :email)
  end

  def correct_host
    @host = Host.find(params[:id])
    redirect_to hosts_host_path(current_host.id) unless @host == current_host
  end
end
