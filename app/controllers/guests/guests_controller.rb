class Guests::GuestsController < ApplicationController
  before_action :correct_guest, only: [:edit, :update]

  def show
    @guest = current_guest
  end

  def edit
    @guest = Guest.find(current_guest.id)
  end

  def update
     @guest = Guest.find(current_guest.id)
    if @guest.update(guest_params)
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
    @guest = Guest.find(current_guest.id)
  end

  def withdraw
    @guest = Guest.find(current_guest.id)
    @guest.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def guest_params
    params.require(:guest).permit(:last_name, :first_name, :last_name_kana,  :first_name_kana,:postal_code, :address, :telephone_number, :email)
  end

  def correct_guest
    @guest = Guest.find(current_guest.id)
    unless @guest == current_guest
      redirect_to my_page_path
    end
  end

end
