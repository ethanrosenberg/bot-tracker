class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.bigint :user_id
      t.timestamp :creation_date
      t.string :handle
      t.string :profile_image_url
      t.integer :followers
      t.integer :tweet_count

      t.timestamps
    end
  end
end
