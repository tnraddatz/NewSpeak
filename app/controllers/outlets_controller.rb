 class OutletsController < ApplicationController

    def index
      @outlets = Outlet.fetch_outlets(outlet: params[:feed_data], limit_num: 6)
      respond_to :html, :js
    end

    def show
      @outlet = Outlet.find(params[:id])
      @articles = @outlet.fetch_articles(published_before: params[:feed_data])
      respond_to :html, :js
    end

end
