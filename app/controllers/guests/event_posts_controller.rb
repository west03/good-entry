class Guests::EventPostsController < ApplicationController
  def show
  @host = Host.find(params[:id])#.order(created_at: :desc).page(params[:page]).per(10)
  end
end
