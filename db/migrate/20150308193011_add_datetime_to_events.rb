class AddDatetimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :datetime, :string
  end
end
