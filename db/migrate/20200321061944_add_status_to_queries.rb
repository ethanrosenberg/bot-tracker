class AddStatusToQueries < ActiveRecord::Migration[5.2]
  def change
    add_column :queries, :status, :string
  end
end
