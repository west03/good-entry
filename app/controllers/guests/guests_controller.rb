class Guests::GuestsController < ApplicationController
  def show
    @guest = current_guest
  end

  def edit
    @guest = current_guest
  end

  def update; end

  def unsubscribe; end

  def withdraw; end
end
