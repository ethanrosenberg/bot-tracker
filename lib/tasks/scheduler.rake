#require Rails.root.join('lib', 'scrape')
#Dir.glob('app/lib/tasks/*.rake').each { |r| load r}

namespace :scheduler do
  desc "Gets latest tweets for desired keyword"
  puts "Starting task..."

  task :twitter => :environment do
      #Rake.application.rake_require "#{Rails.root}/lib/scrape.rb"
      #include Scrape
      #require 'scrape'
      #include Scrape
      #Scrape.new_search

      Resque.enqueue(Harvest::Twitter)
      

  end
  puts "Finished task."
end
