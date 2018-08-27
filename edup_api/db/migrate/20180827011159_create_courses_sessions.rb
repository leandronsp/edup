class CreateCoursesSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :courses_sessions, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :session, index: true
    end
  end
end
