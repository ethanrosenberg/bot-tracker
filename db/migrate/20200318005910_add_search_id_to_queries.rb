class AddSearchIdToQueries < ActiveRecord::Migration[5.2]
  def change
    add_reference :queries, :search, foreign_key: true
  end
end
