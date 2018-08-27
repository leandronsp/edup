class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name
      t.belongs_to :course, foreign_key: true, index: true, type: :uuid

      t.timestamps
    end
  end
end
