require 'news-api'

  #-------------------------------------------------------------#
  #The news_manager module contains all the methods required to #
  #   insert news from NewsAPI into the articles database       #
  #-------------------------------------------------------------#

# -------------------------Information--------------------------------------#
#   In order to save an outlet and its respected articles, the      				#
# NewsManager module will call 5 class: NewsApiCall > DatabaseTransactor >  #
# SaveArticle > DuplicateOutlet? ~ SaveNewOutlet > SaveArticle      				#
# --------------------------------------------------------------------------#

# ------------------------(  1 of 5  )------------------------------#
#  The NewsApiCall class will recieve articles from the NewsAPI and #
#   return articles in order to begin the process of putting the    #
#                news articles into the database.                   #
# ------------------------------------------------------------------#

module NewsManager
	class NewsApiCaller < ApplicationService

    #list_of_sources = 'cnn, fox-news, msnbc, reddit-r-all, politico'
    def initialize(str_list_of_sources)
			@newsapi = News.new("f5727dd7341d46bc8c0abaccb372c4ad")
      @str_list_of_sources = str_list_of_sources
		end

		def call
			@articles = @newsapi.get_everything(sources: @str_list_of_sources,
																							language: 'en', pageSize: 99)
		end

  end
end

#---------------REMINDER: TO DELETE DATATBASE MIGRATIONS----------------------#
#CHECK COLUMN DATATYPES WITH Article.column_for_attribute('publishedAt').type
#Delete migrations rake db:drop
#rake db:rollback
#rails d migration 'migration name'
#rails db:create .. migrate
