class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name

      t.timestamps
    end
  end
end
