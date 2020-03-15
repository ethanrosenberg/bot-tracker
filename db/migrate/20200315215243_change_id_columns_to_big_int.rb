class ChangeIdColumnsToBigInt < ActiveRecord::Migration[5.2]
  def change
    change_column :tweets, :tweet_id, :bigint
    change_column :tweets, :user_id, :bigint

  end
end
