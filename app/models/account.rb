class Account < ApplicationRecord
  after_create :run_report
  after_save :update_dashboard_accounts
  has_one :report



  def update_dashboard_accounts
    ActionCable.server.broadcast 'web_notifications_channel', total_accounts: Account.all.count
  end

  def run_report
    #byebug
    #byebug
    new_report = Report.new do |report|
      report.tweets_per_day = calculate_tweets_per_day()
      report.default_profile_pic = self.default_profile_pic
      report.retweet_percentage = self.retweet_percentage_total
      report.languages_found = self.languages.count
      report.save
    end
    self.report = new_report
    self.save

  end


  def calculate_tweets_per_day
    begin
      #byebug

      days_since_opening = (Date.today - self.creation_date.to_datetime).to_i
      self.tweet_count / days_since_opening
    rescue
      puts "Hmm have an error calculating tweets per day... Days Since Opening - #{days_since_opening} || Tweet Count - #{self.tweet_count}"
    end
  end

  def created_at
    self[:created_at].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")
  end

  def updated_at
    self[:updated_at].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")
  end

  def creation_date
    self[:creation_date].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y")
  end

end
