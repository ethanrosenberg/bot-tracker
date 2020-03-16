class Account < ApplicationRecord
  after_create :run_report

  has_one :report

  def run_report
    #byebug
    new_report = Report.new do |report|
      report.tweets_per_day = calculate_tweets_per_day()
      report.default_profile_pic = self.default_profile_pic
      report.save
    end
    self.report = new_report
    self.save

  end

  def calculate_tweets_per_day
    begin

      days_since_opening = (Date.today - self.creation_date.to_datetime).to_i
      self.tweet_count / days_since_opening
    rescue
      puts "Hmm have an error calculating tweets per day... Days Since Opening - #{days_since_opening} || Tweet Count - #{self.tweet_count}"
    end
  end
end
