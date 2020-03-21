#require 'byebug'

module Harvest


  class TwitterWorker

    #TWEETS_PER_TIMELINE = Setting.first.tweets_per_timeline if Setting.first.nil?
    #TWEETS_PER_KEYWORD = 25
    #SLEEP = 7

    @queue = :harvest

    def initialize(query_id, keyword)

      @query_id = query_id
      @query_keyword = keyword
      @query = Query.find(query_id)
      if !Setting.first.nil?
        @tweets_per_timeline = Setting.first.tweets_per_timeline
        @tweets_per_keyword = Setting.first.tweets_per_keyword
        @sleep = Setting.first.sleep
      else
        @tweets_per_timeline = 200
        @tweets_per_keyword = 25
        @sleep = 7
      end



      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["CONSUMER_KEY"]
        config.consumer_secret     = ENV["CONSUMER_SECRET"]
        config.access_token        = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_SECRET"]
      end

    end

    def self.perform(query_id, keyword)
      Harvest::TwitterWorker.new(query_id, keyword).start
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

    def update_progress
      percent_finished_string = get_percentage_done()
      ActionCable.server.broadcast 'web_notifications_channel', message: percent_finished_string, id: @query.search.id, results: @query.search.results, status: @query.search.status
    end

    def get_percentage_done
      #current_done = Query.where("status = ?", 'done').count
      current_done = Query.where(status: "done").where(search_id: @query.search_id).count
      queries_count = Keyword.all.count


      current_percentage = ((current_done.to_f.round(2) / queries_count.to_f.round(2)) * 100).round(1).to_i.to_s
      @query.search.percent_finished = current_percentage
      @query.search.save

      Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
        Rails.logger.info "Updating progress: #{@query_keyword} #{current_percentage}% - current_done: #{current_done} total_queries: #{queries_count}"
      end

      current_percentage
    end

    def get_user_tweets_percentage(user_id)


      returned_count = 0;
      retweet_count = 0
      puts "Getting user id: #{user_id} tweets..."
      @client.user_timeline(user_id, count: @tweets_per_timeline).each do |tweet|

        if !tweet.retweeted_status.blank?
          retweet_count += 1
        end
        returned_count += 1
      end

      percentage = ((retweet_count.to_f.round(2) / returned_count.to_f.round(2)) * 100).round(1).to_i.to_s

      puts "Sleeping before next timeline harvest..."
      sleep @sleep

      { retweet_percentage: percentage, collected: returned_count, retweets: retweet_count }


    end

    def check_for_default_picture(url)
     if url.include? "https://abs.twimg.com/sticky/default_profile_images/default_profile"
       return true
     else
       return false
     end

    end

    def create_account(tweet)
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

    def start

      Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
        Rails.logger.info "Starting Query with settings sleep(#{@sleep}), tweets_per_timeline(#{@tweets_per_timeline}), tweets_per_keyword(#{@tweets_per_keyword})"
      end

      #byebug
      #results_count = 0
      unless @query.search.status == 'finished' || @query.search.status == 'stopped'
        Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
          Rails.logger.info "scraping keyword: #{@query_keyword}"
          Rails.logger.info "search status: #{@query.search.status}"
        end

          @client.search(@query_keyword).take(@tweets_per_keyword).each do |tweet|

            create_account(tweet)

              unless tweet_already_exists(tweet.id)
                create_tweet(tweet)
                @query.search.results = (@query.search.results || 0) + 1
                @query.search.save
                #esults_count += 1
              end

          end
          Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
            Rails.logger.info "zzzzz... #{@sleep} seconds."
          end


          sleep @sleep

      end

      @query.status = "done"
      @query.save

      update_progress()

      #update_progress()

      Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
        Rails.logger.info "Finished harvest."
      end
      #@word.finish
    end

  end

end
