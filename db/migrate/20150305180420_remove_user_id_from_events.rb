class RemoveUserIdFromEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.remove :user_id
    end
  end
end
