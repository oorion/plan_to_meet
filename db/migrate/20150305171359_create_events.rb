class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.references :group, index: true
      t.references :user, index: true
      t.references :address, index: true

      t.timestamps null: false
    end
    add_foreign_key :events, :groups
    add_foreign_key :events, :users
    add_foreign_key :events, :addresses
  end
end
