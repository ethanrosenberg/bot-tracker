class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.integer :tweet_id
      t.string :text
      t.timestamp :created_at
      t.integer :user_id
      t.timestamp :profile_created_at
      t.string :profile_handle
      t.string :profile_image_url
      t.integer :followers

      t.timestamps
    end
  end
end
