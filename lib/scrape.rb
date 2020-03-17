require 'after_do'

module Scrape

  SLEEP = 7
  @queue = :scrape

    def self.start_scrape

        @client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["CONSUMER_KEY"]
          config.consumer_secret     = ENV["CONSUMER_SECRET"]
          config.access_token        = ENV["ACCESS_TOKEN"]
          config.access_token_secret = ENV["ACCESS_SECRET"]
        end


        new_search = Search.create(keyword: Keyword.all.map {|kw| kw.term}.join(", "))

        results_count = 0
        Keyword.all.each do |item|
          STDERR.puts "Scraping keyword (#{item.term})"
            @client.search(item.term).take(50).each do |tweet|

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

        #new_search.finish

        #new_search.status = "finished"
        #new_search.save

        STDERR.puts "Finished Scraping. Found #{new_search.results} new tweets"
        new_search.id

    end

    def finish(id)
      search_job = Search.find(id)
      search_job.status = "finished"
      search_job.save
    end

    def self.get_user_tweets_percentage(user_id)


      returned_count = 0;
      retweet_count = 0
      puts "Getting user id: #{user_id} tweets..."
      @client.user_timeline(user_id, count: 200).each do |tweet|

        if !tweet.retweeted_status.blank?
          retweet_count += 1
        end
        returned_count += 1
      end

      percentage = ((retweet_count.to_f.round(2) / returned_count.to_f.round(2)) * 100).round(1).to_i.to_s

      puts "Sleeping before next timeline harvest..."
      sleep SLEEP

      { retweet_percentage: percentage, collected: returned_count, retweets: retweet_count }


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
            default_url = "https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png"
            ac.default_profile_pic = check_for_default_picture(tweet.user.profile_image_url_https.to_s)
            #byebug
            percentage_data = get_user_tweets_percentage(tweet.user.id)
            #{ retweet_percentage: percentage, collected: returned_count, retweet_count: retweet_count }
            ac.rt_percentage = "RT Stats: #{percentage_data[:retweet_percentage]}% (retweets: #{percentage_data[:retweets]}, collected: #{percentage_data[:collected]})"

        end
      end


    end

    def self.check_for_default_picture(url)
     if url.include? "https://abs.twimg.com/sticky/default_profile_images/default_profile"
       return true
     else
       return false
     end

    end


    def self.tweet_already_exists(id)
      Tweet.where(:tweet_id => id).blank? ? false : true
    end



    def self.perform
      puts "AMAZING!!! IT WORKED!"
      start_scrape()
    end


end

Scrape.extend AfterDo
Scrape.after :start_scrape do |return_value|
  finish(return_value)
end
#Scrape.after :start_scrape do cool_stuff end
