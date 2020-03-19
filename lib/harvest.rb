#require 'byebug'

module Harvest


  class Twitter

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end

    @queue = :harvest

    def initialize(query_id, keyword)

      @query_id = query_id
      @query_keyword = keyword
      @query = Query.find(query_id)
      @sleep = 7

    end

    def self.perform(query_id, keyword)
      #search = Search.create(status: 'working')
      STDERR.puts "queryid: #{query_id} keyword: #{keyword}"
      Harvest::Twitter.new(query_id, keyword).start
    end

    def create_tweet(tweet)

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

    def tweet_already_exists(id)
      Tweet.where(:tweet_id => id).blank? ? false : true
    end

    def start

      #byebug

      unless @query.search.status == 'finished' || @query.search.status == 'stopped'
        STDERR.puts "scraping keyword: #{@query_keyword}"
        STDERR.puts "zzzzz... 15 seconds."

        results_count = 0
        @@client.search(@query_keyword).take(50).each do |tweet|

          unless tweet_already_exists(tweet.id)
            create_tweet(tweet)
            results_count += 1
          end

          @query.search.results = results_count
          @query.search.save

          sleep 7

        end



      end




      puts "Finished harvest."
      #@word.finish
    end

  end

end
