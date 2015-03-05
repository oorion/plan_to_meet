class Event < ActiveRecord::Base
  belongs_to :group
  belongs_to :address

  has_many :user_events
  has_many :users, through: :user_events
end
