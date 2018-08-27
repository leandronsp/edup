class CreateRolesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :roles_users, id: false do |t|
      t.belongs_to :role, index: true, type: :uuid
      t.belongs_to :user, index: true, type: :uuid
    end
  end
end
