  #-------------------------------------------------------------#
  #The news_manager module contains all the methods required to #
  #   insert news from NewsAPI into the articles database       #
  # 		For Further Information Check NewsApiCall class					#
  #-------------------------------------------------------------#

# ------------------------(  4 of 5  )------------------------------#
#   The DuplicateArticle class will check if an outlet has already  #
# been created in the database.  If the outlet has no name, it will #
#         save it under "Anonymous Source" outlet_name              #
# ------------------------------------------------------------------#

module NewsManager
	class DuplicateOutlet < ApplicationService

    def initialize(outlet_name)
			@outlet_name = outlet_name
		end

    #Push to the database
		def call
      #If outlet_name is null or empty
      if @outlet_name.blank?
        @outlet_name = "Anonymous Source"
      end
      #If outletName exists then we should skip and not make a new one
      return Outlet.where("outlet_name = ?", @outlet_name).present?
    end

  end
end
