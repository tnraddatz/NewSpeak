 class StaticPagesController < ApplicationController

   def home
     if params[:feed_data]
       @articles = Article.update_feed(params[:feed_data], 5)
     else
       @articles = Article.default_feed(10)
       @outlet_images = Outlet.preview_outlet_images(10)
     end
     respond_to do |format|
       format.html
       format.js
     end
   end

   def about

   end


end
