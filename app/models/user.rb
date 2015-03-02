class User < ActiveRecord::Base
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(email: auth.email)
    user.save
    user
  end
end
