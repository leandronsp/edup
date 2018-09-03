class CreateCoursesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :courses_users, id: false do |t|
      t.belongs_to :course, index: true, type: :uuid
      t.belongs_to :user, index: true, type: :uuid
    end

    add_index :courses_users, [:course_id, :user_id], unique: true
  end
end
