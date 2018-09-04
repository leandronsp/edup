class AddSourceUrlToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :source_url, :string
  end
end
