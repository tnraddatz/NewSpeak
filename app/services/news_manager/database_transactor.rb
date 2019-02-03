#-------------------------------------------------------------#
#The news_manager module contains all the methods required to #
#   insert news from NewsAPI into the articles database       #
# 		For Further Information Check NewsApiCall class		  #
#-------------------------------------------------------------#

# ------------------------(  2 of 5  )-------------------------------#
# The PutNews class will recieve articles from the NewsApiCall Class #
# and will check if an article's outlet is new or a duplicate. If it #
# is a "new outlet", it will call SaveNewOutlet class and continue.  #
# 	For each article that it recieves, the class will save the 	     #
#  					article by calling the SaveArticle class.		 #
# -------------------------------------------------------------------#


module NewsManager
	class DatabaseTransactor < ApplicationService

		def initialize(all_articles)
			@articles = all_articles
		end

		def call
			amountAddedToDatabase = 0
			ActiveRecord::Base.transaction do
				@articles.each {|article|
					#Check if the outlet already exists in the database
					if !NewsManager::DuplicateOutlet.call(article.name)
						NewsManager::OutletSaver.call(article.name, article.url)
					end
					#save the article
					if NewsManager::ArticleSaver.call(article)
						amountAddedToDatabase += 1
					end
				}
			end
			#Change this to log output
			updateString = amountAddedToDatabase.to_s + " records added to database"
			#puts updateString
			return updateString
	  end

	end
end
