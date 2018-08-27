class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
