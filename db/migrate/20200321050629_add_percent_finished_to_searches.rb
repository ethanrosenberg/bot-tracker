class AddPercentFinishedToSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :percent_finished, :integer
  end
end
