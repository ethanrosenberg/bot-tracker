class AddQueryToTweets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :query, foreign_key: true
  end
end
