desc "Gets latest tweets for desired keyword"
task scrape_tweets: :environment do
  puts "Scraping tweets..."
  Scrape::Twitter.scrape
  puts "tweets scraped!"
end
