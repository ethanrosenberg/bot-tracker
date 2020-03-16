class AddDefaultProfilePicToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :default_profile_pic, :boolean
  end
end
