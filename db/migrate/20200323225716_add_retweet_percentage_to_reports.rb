class AddRetweetPercentageToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :retweet_percentage, :integer
  end
end
