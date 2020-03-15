

module Harvest

  SLEEP = 5

    def self.start_scrape

        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["CONSUMER_KEY"]
          config.consumer_secret     = ENV["CONSUMER_SECRET"]
          config.access_token        = ENV["ACCESS_TOKEN"]
          config.access_token_secret = ENV["ACCESS_SECRET"]
        end

        ::Keyword.all.each do |item|
          STDERR.puts "Scraping keyword (#{item.term})"
            client.search(item.term).take(5).each do |tweet|
                ::Tweet.create do |t|
                  #t.tweet_id = tweet.id
                  t.text = tweet.text
                  t.created_at = tweet.created_at
                  #t.user_id = tweet.user.id
                  t.profile_created_at = tweet.user.created_at
                  t.profile_handle = tweet.user.screen_name
                  t.profile_image_url = tweet.user.profile_image_url_https.to_s
                  t.followers = tweet.user.followers_count
                end
            end
          STDERR.puts "Sleeping for #{SLEEP} seconds zzz..."
          sleep SLEEP
        end

          STDERR.puts "Finished Scraping."

    end

    def self.test_scrape

      puts "a"

    end

end
