	#-------------------------------------------------------------#
	#The news_manager module contains all the methods required to #
	#   insert news from NewsAPI into the articles database       #
	# 		For Further Information Check NewsApiCall class					#
	#-------------------------------------------------------------#

# ------------------------INFORMATION-------------------------------#
# The following class is called if you want to be returned specific	#
# news articles from singular sources. It should be called using 		#
# 													the calls:    													#
#     hardCodedArray = ["CNN", "Breitbart News", "MSNBC", 					#
#              "Fox News", "BBC News", "Politico"]									#
#    @allSelectedNews = NewsManager::GetNews.call(hardCodedArray)		#
# ------------------------------------------------------------------#

module NewsManager
	class NewsRetriever < ApplicationService

		def initialize(outlets_array)
			@outlets_array = outlets_array
		end

		def call
		  outlets = Outlet.where(outlet_name: @outlets_array)
		  return outlets
		end

  end
end
