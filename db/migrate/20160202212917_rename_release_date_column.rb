class RenameReleaseDateColumn < ActiveRecord::Migration
  def change
    rename_column :movies, :release_data, :release_date
  end
end
