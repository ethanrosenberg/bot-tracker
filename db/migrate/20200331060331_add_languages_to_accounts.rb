class AddLanguagesToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :languages, :string, array: true, default: []
  end
end
