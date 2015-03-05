class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :event, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :recommendations, :events
    add_foreign_key :recommendations, :users
  end
end
