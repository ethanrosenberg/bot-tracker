namespace :clean do
  desc "Cleans account and report tables."
  puts "Starting wipe"

  task :db => :environment do
      #Rake.application.rake_require "#{Rails.root}/lib/scrape.rb"
      #include Scrape
      #require 'scrape'
      #include Scrape
      #Scrape.start_scrape
      Report.destroy_all
      Account.destroy_all
      Tweet.destroy_all
      Search.destroy_all
      Query.destroy_all


  end
  puts "Finished wipe"
end
