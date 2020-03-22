class AddSearchIdToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :search_id, :integer
  end
end
