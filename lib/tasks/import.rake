# Example rake file structure
# Define a namespace for the task
namespace :import do
  # Give a description for the task
  desc 'Import Data from NewsApi'
  # Define the task
  task news: :environment do

    #GETNEWS FROM HARDCODED SOURCES
    first_articles = NewsManager::NewsApiCaller.call('breitbart-news, cnn, fox-news, msnbc, the-washington-times,
                                                the-economist, the-washington-post, financial-post, the-wall-street-journal,
                                                nhl-news, nfl-news')

    first_records = NewsManager::DatabaseTransactor.call(first_articles)

    second_articles = NewsManager::NewsApiCaller.call('abc-news, bbc-news, bleacher-report, cbc-news, cbs-news,
                                                       fortune, google-news, reuters, the-hill, vice-news')

    second_records = NewsManager::DatabaseTransactor.call(second_articles)

    first_recordsAdded = "First_records added: " + first_records + " articles"
    second_recordsAdded = "Secord_records added: " + second_records + " articles"
    #This will log the output to /var/log/cron.log (see config/scheduler.rb)
    puts first_recordsAdded
    puts second_recordsAdded
  end
end
