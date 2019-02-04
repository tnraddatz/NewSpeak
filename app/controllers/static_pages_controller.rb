class StaticPagesController < ApplicationController

  def home
    @articles = if params[:feed_data]
                  Article.update_feed(params[:feed_data], 5)
                else
                  @outlet_images = Outlet.preview_outlet_images(10)
                  Article.default_feed(10)
                end
    respond_to :html, :js
  end

  def about
  end


end
