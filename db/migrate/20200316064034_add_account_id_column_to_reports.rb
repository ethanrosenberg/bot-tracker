class AddAccountIdColumnToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :account, foreign_key: true
  end
end
