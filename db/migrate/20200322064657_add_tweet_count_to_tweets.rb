class AddTweetCountToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :tweet_count, :integer
    add_column :tweets, :default_url, :string
    add_column :tweets, :default_profile_pic, :boolean
    
  end
end
