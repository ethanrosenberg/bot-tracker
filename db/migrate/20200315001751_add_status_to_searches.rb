class AddStatusToSearches < ActiveRecord::Migration[5.2]
  def changev
    add_column :search, :status, :string
  end
end
