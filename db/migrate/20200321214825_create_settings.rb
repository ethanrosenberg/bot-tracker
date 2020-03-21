class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.integer :sleep
      t.integer :tweets_per_keyword
      t.integer :tweets_per_timeline

      t.timestamps
    end
  end
end
