class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :tweets_per_day
      t.boolean :default_profile_pic
      t.integer :score

      t.timestamps
    end
  end
end
