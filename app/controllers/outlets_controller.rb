class OutletsController < ApplicationController

  def index
    @outlets = if params[:feed_data]
                 Outlet.where(outlet_name: params[:feed_data])
               else
                 Outlet.limit(5)
               end

    respond_to :html, :json
  end

  def show
    @outlet = Outlet.find(params[:id])
    @articles = if params[:feed_data]
                  @outlet.update_feed(params[:feed_data], 5)
                else
                  @outlet.default_feed(10)
                end

    respond_to :html, :json
  end

end
