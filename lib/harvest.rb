#require 'byebug'

module Harvest


  class TwitterWorker



    @queue = :harvest

    def initialize(query_id, keyword)

      @query_id = query_id
      @query_keyword = keyword
      @query = Query.find(query_id)
      @sleep = 7

      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["CONSUMER_KEY"]
        config.consumer_secret     = ENV["CONSUMER_SECRET"]
        config.access_token        = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_SECRET"]
      end

    end

    def self.perform(query_id, keyword)
      #search = Search.create(status: 'working')
      #Rails.logger.info "test again"
      #STDERR.puts "queryid: #{query_id} keyword: #{keyword}"
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
      ActionCable.server.broadcast 'web_notifications_channel', message: percent_finished_string, id: @query.search.id
    end

    def get_percentage_done
      #current_done = Query.where("status = ?", 'done').count
      current_done = Query.where(status: "done").where(search_id: @query.search_id).count + 1
      queries_count = Keyword.all.count


      current_percentage = ((current_done.to_f.round(2) / queries_count.to_f.round(2)) * 100).round(1).to_i.to_s
      @query.search.percent_finished = current_percentage
      @query.search.save

      Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
        Rails.logger.info "Updating progress: #{@query_keyword} #{percentage}% - current_done: #{current_done} total_queries: #{queries_count}"
      end

      current_percentage
    end

    def start

      #byebug
      #results_count = 0
      unless @query.search.status == 'finished' || @query.search.status == 'stopped'
        Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
          Rails.logger.info "scraping keyword: #{@query_keyword}"
          Rails.logger.info "search status: #{@query.search.status}"
        end

          @client.search(@query_keyword).take(5).each do |tweet|

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

          update_progress()
          sleep @sleep

      end

      @query.status = "done"
      @query.save

      update_progress()

      Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
        Rails.logger.info "Finished harvest."
      end
      #@word.finish
    end

  end

end
