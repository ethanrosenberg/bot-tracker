class AddRtPercentageToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :rt_percentage, :string
  end
end
