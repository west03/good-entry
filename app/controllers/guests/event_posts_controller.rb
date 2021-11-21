class Guests::EventPostsController < ApplicationController
  before_action :authenticate_guest!
  def show
    @host = Host.find(params[:id])
    @hosts = @host.events.order(created_at: :desc).page(params[:page]).per(10)
  end

  def search
    @host = Host.find(params[:event_post_id])
    events = []
    @host.events.reverse.each do |ee|
      events << ee if ee.title.match(/#{params[:keyword]}/)
    end
    @hosts = Kaminari.paginate_array(events).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
  end
end
