class AddTweetToQueries < ActiveRecord::Migration[5.2]
  def change
    add_reference :queries, :tweet, foreign_key: true
  end
end
