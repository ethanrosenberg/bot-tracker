class Search < ApplicationRecord
  after_create :start_jobs
  #after_commit :update_progress
  #after_update :update_progress


  has_many :queries

  def update_progress

    ActionCable.server.broadcast 'web_notifications_channel', message: self.percent_finished, id: self.id
  end

  def start_jobs

    #ActionCable.server.broadcast 'messages',
      #message: 99
    #head :ok

    #STDERR.puts "starting twitter scraper..."
    Keyword.all.each do |keyword|

      self.queries.create(keyword: keyword.term, status: "working")
    end

    Resque.enqueue(Harvest::ResultsWorker, self.id)



  end



  def self.stop_jobs(id)

    Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
      Rails.logger.info "Stopping jobs..."
    end

    Search.find(id).queries.each do |job|
      job.stop_job
    end

    Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
      Rails.logger.info "All jobs stopped. Finished"
    end
    #byebug
    #self.queries.each do |query|
    #  query.stop_job
    #end
    #Search.queries.where(:search_id => id).each do |job|
      #byebug
    #  job.stop_job
    #end
  end



    #Scrape::Twitter.scrape

    #mark_finished



  def scrape_tweets(keyword, client)

    client.search(keyword).take(5).each do |tweet|

      Tweet.create do |t|
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

  end

  def created_at
    self[:created_at].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")
  end

  def updated_at
    self[:updated_at].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")
  end

  def mark_finished
    self.status = 'finished'
    save
  end

end
