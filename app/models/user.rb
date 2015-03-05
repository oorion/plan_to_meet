class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  has_many :recommendations
  has_many :events, through: :recommendations

  validates_uniqueness_of :uid

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(uid: auth["uid"])
    user.access_token = auth["credentials"]["token"]
    if user.save
      user
    end
  end
end
