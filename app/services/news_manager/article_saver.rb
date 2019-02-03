#-------------------------------------------------------------#
#The news_manager module contains all the methods required to #
#   insert news from NewsAPI into the articles database       #
# 		For Further Information Check NewsApiCall class					#
#-------------------------------------------------------------#

# ------------------------(  3 of 5  )------------------------------#
# 		The SaveArticle class recieves an article from the PutNews   	#
#  class and will save the article under its respected Outlet. 		  #
# ------------------------------------------------------------------#

module NewsManager
	class ArticleSaver < ApplicationService

		def initialize(article)
			@article = article
		end

		#Push to the database
		def call
			outlet = Outlet.find_by(outlet_name: @article.name)
			outlet.total_records += 1 #This will be a nightmare to update if an article is deleted, need to change in future
			new_article = outlet.articles.build(description: @article.description, outlet_name: @article.name,
											author: @article.author, title: @article.title, url: @article.url, urltoimage: @article.urlToImage,
											published_at: @article.publishedAt.to_datetime, record_number: outlet.total_records)
			begin
				outlet.save
			rescue => e
				#Fix this to also put error in logs
				return false
			end

		end

	end
end
