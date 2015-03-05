class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_events, :users
    add_foreign_key :user_events, :events
  end
end
