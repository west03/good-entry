class Admins::HostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @hosts = Host.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @host = Host.find(params[:id])
  end

  def edit
    @host = Host.find(params[:id])
  end

  def update
    @host = Host.find(params[:id])
    if @host.update(host_params)
      redirect_to admins_host_path(@host.id)
    else
      render :edit
    end
  end

  private

  def host_params
    params.require(:host).permit(:name, :postal_code, :address, :telephone_number, :email, :is_active)
  end
end
