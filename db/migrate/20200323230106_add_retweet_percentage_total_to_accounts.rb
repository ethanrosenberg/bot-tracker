class AddRetweetPercentageTotalToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :retweet_percentage_total, :integer
  end
end
