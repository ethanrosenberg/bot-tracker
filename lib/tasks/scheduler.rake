#equire Rails.root.join('lib', 'sleeper')
#require 'resque'
require "resque/tasks"
#require Rails.root.join('app/jobs', 'sleeper')
#Dir.glob('app/lib/tasks/*.rake').each { |r| load r}


namespace :scheduler do
  desc "Gets latest tweets for desired keyword"
  puts "Starting task..."

  task :twitter => :environment do
    #require Rails.root.join('app/jobs', 'sleeper')

    #include Sleeper
      #Rake.application.rake_require "#{Rails.root}/lib/scrape.rb"
      #include Scrape
      #require 'scrape'
      #include Scrape
      #Scrape.new_search
      Search.create(status: "working", percent_finished: 0)

      #Resque.enqueue(Sleeper::Wake, 5)




  end
  puts "Finished task."
end
