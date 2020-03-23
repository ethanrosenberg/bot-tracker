class Tweet < ApplicationRecord

  after_save :update_dashboard_tweets

  belongs_to :query

  def update_dashboard_tweets
    ActionCable.server.broadcast 'web_notifications_channel', total_tweets: Tweet.all.count
  end

  def created_at
    self[:created_at].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")
  end

  def updated_at
    self[:updated_at].in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")
  end

end
