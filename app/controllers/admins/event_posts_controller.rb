class Admins::EventPostsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @host = Host.find(params[:id])
    @events = @host.events.page(params[:page]).per(10)
  end

  def search
    @host = Host.find(params[:event_post_id])
    events = []
    @host.events.each do |ee|
      events << ee if ee.title.match(/#{params[:keyword]}/)
    end
    @events = Kaminari.paginate_array(events).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
  end
end
