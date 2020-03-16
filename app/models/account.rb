class Account < ApplicationRecord
  after_create :run_report

  has_one :report

  def run_report
    #byebug
    new_report = Report.new do |report|
      report.tweets_per_day = calculate_tweets_per_day()
      report.save
    end
    self.report = new_report
    self.save

  end

  def calculate_tweets_per_day
    days_since_opening = (Date.today - self.creation_date.to_datetime).to_i
    self.tweet_count / days_since_opening
  end
end
