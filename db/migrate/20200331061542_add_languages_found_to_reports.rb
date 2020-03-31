class AddLanguagesFoundToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :languages_found, :integer
  end
end
