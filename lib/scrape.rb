
module Scrape

  SLEEP = 7

    def self.start_scrape

        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["CONSUMER_KEY"]
          config.consumer_secret     = ENV["CONSUMER_SECRET"]
          config.access_token        = ENV["ACCESS_TOKEN"]
          config.access_token_secret = ENV["ACCESS_SECRET"]
        end


        new_search = Search.create(keyword: Keyword.all.map {|kw| kw.term}.join(", "), status: "working")

        results_count = 0
        Keyword.all.each do |item|
          STDERR.puts "Scraping keyword (#{item.term})"
            client.search(item.term).take(5).each do |tweet|

              create_account(tweet)

              unless tweet_already_exists(tweet.id)

                create_tweet(tweet)
                results_count += 1
              end

                new_search.results = results_count
                new_search.save
            end
          STDERR.puts "Sleeping for #{SLEEP} seconds zzz..."
          sleep SLEEP
        end

        new_search.status = "finished"
        new_search.save

        STDERR.puts "Finished Scraping. Found #{new_search.results} new tweets"

    end

    def self.create_tweet(tweet)

      Tweet.create do |t|
          t.tweet_id = tweet.id
          t.text = tweet.text
          t.created_at = tweet.created_at
          t.user_id = tweet.user.id
          t.profile_created_at = tweet.user.created_at
          t.profile_handle = tweet.user.screen_name
          t.profile_image_url = tweet.user.profile_image_url_https.to_s
          t.followers = tweet.user.followers_count
      end

    end

    def self.create_account(tweet)
      #byebug
      if Account.where(:user_id => tweet.user.id).blank?
        Account.create do |ac|
            ac.user_id = tweet.user.id
            ac.creation_date = tweet.user.created_at
            ac.handle = tweet.user.screen_name
            ac.profile_image_url = tweet.user.profile_image_url_https.to_s
            ac.followers = tweet.user.followers_count
            ac.tweet_count = tweet.user.statuses_count

        end
      end


    end


    def self.tweet_already_exists(id)
      Tweet.where(:tweet_id => id).blank? ? false : true
    end


end
