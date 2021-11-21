class Hosts::GuestsController < ApplicationController
  before_action :authenticate_host!
  def show
    @guest = Guest.find(params[:id])
  end
end
