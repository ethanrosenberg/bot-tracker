class AddResultCountToSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :results, :integer
  end
end
