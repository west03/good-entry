class Guests::EventPostsController < ApplicationController
  def show
  @host = Host.find(params[:id])
  @hosts = @host.events.order(created_at: :desc).page(params[:page]).per(10)
  end

  def search
    @host = Host.find(params[:event_post_id])
    events = []
    @host.events.each do |ee|
      if ee.title.match(/#{params[:keyword]}/)
        events << ee
      end
    end
    @hosts = Kaminari.paginate_array(events).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :show
  end
end
