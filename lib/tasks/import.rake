# Example rake file structure
# Define a namespace for the task
namespace :import do
  # Give a description for the task
  desc 'Import Data from NewsApi'
  # Define the task
  task news: :environment do

    #GETNEWS FROM HARDCODED SOURCES
    articles = NewsManager::NewsApiCaller.call('breitbart-news, cnn, fox-news, msnbc, the-washington-times,
                                                the-economist, the-washington-post, financial-post, the-wall-street-journal,
                                                nhl-news, nfl-news')

    recordsAdded = NewsManager::DatabaseTransactor.call(articles)
    #This will log the output to /var/log/cron.log (see config/scheduler.rb)
    puts recordsAdded
  end
end
