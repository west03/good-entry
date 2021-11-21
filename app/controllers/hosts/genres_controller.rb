class Hosts::GenresController < ApplicationController
  before_action :authenticate_host!
  before_action :current_host
  def index
    @genres = current_host.genres.order(created_at: :desc).page(params[:page]).per(25)
    @genre = Genre.new
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to hosts_genres_path
    else
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to hosts_genres_path
    else
      render :edit
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to hosts_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :host_id)
  end
end
