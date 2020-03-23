class Report < ApplicationRecord
  #after_create :run_analysis

  belongs_to :account

  def created_at
    self[:created_at].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")
  end

  def updated_at
    self[:updated_at].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")
  end

  def self.get_bots_found
    Report.where("tweets_per_day >= ? AND retweet_percentage >= ?", 50, 75).count
  end


  #def process()



end
