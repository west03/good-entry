class Hosts::HostsController < ApplicationController
   before_action :correct_host, only:[:show, :edit, :update]
  def show
    @host = current_host
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

  private

  def host_params
    params.require(:host).permit(:name, :postal_code, :address, :telephone_number, :email)
  end

  def correct_host
    @host = Host.find(params[:id])
    unless @host == current_host
      redirect_to hosts_host_path(current_host.id)
    end
  end
end
