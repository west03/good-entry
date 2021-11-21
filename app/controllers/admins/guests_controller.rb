class Admins::GuestsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @guests = Guest.all.page(params[:page]).per(10)
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def update
    @guest = Guest.find(params[:id])
    if @guest.update(guest_params)
      redirect_to admins_guest_path(@guest.id)
    else
      render :edit
    end
  end

  def search
    @guests = Guest.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :index
  end

  private

  def guest_params
    params.require(:guest).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address,
                                  :telephone_number, :email, :is_active)
  end
end
