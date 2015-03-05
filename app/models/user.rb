class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(email: auth.email, access_token: auth["credentials"]["token"], uid: auth["uid"])
    user.save
    user
  end
end
