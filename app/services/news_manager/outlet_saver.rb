#-------------------------------------------------------------#
#The news_manager module contains all the methods required to #
#   insert news from NewsAPI into the articles database       #
# 		For Further Information Check NewsApiCall class					#
#-------------------------------------------------------------#

# ------------------------(  5 of 5  )------------------------------#
# The SaveNewOutlet class will recieve input from the PutNews		    #
# class and save a new outlet, filling in the outlet_name, siteurl, #
#         imageurl, and total_records parameters                    #
# ------------------------------------------------------------------#


module NewsManager
	class OutletSaver < ApplicationService
    def initialize(outlet_name, outlet_url)
			@outlet_name = outlet_name
      @outlet_url = outlet_url
		end

		#Push to the database
		def call
      #get url icon and base url
      base_url = getBaseUrl(@outlet_url)
      iconBuilder = iconBuilder(base_url)
      #Save the Outlet
      outlet = Outlet.new(outlet_name: @outlet_name, siteurl: base_url, imageurl: iconBuilder, total_records: 0)
      outlet.save
    end

    private
      #Use 3rd party web app to create the favicon for the news-source
      def iconBuilder(base_url)
        iconString = 'https://besticon-demo.herokuapp.com/icon?url=' + base_url + '&size=70..120..200'
        return iconString
      end

      def getBaseUrl(outlet_url)
        begin
          base_url = URI.parse(@outlet_url).host #ConvertToBaseUrl(@outlet_url)
        rescue => e
          base_url = " "
        end
      end

  end
end
