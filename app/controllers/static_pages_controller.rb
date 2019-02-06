 class StaticPagesController < ApplicationController

   def home
     @outlet_images = Outlet.preview_outlet_images(10)
     @articles = Article.fetch_articles(published_before: params[:feed_data], limit_num: 9)
     respond_to :html, :js
   end

   def about
   end

   def download_resume
     send_file("#{Rails.root}/public/Thomas_Raddatz.pdf")
   end

end
