 class OutletsController < ApplicationController

    def index
      if params[:feed_data]
        @outlets = Outlet.where("outlet_name > ?", params[:feed_data])
      else
        @outlets = Outlet.limit(5)
      end

      respond_to do |format|
        format.html
        format.js
      end
    end

    def show
      @outlet = Outlet.find(params[:id])
      if params[:feed_data]
        @articles = @outlet.update_feed(params[:feed_data], 5)
      else
        @articles = @outlet.default_feed(10)
      end

      respond_to do |format|
        format.html
        format.js
      end
    end

end
