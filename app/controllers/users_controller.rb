class UsersController < ApplicationController
  def show
  end

  def text
    twilio_sid = ENV["TWILIO_SID"]
    twilio_auth_token = ENV["TWILIO_AUTH_TOKEN"]
    @client = Twilio::REST::Client.new twilio_sid, twilio_auth_token
    @client.account.messages.create({
      from: "+15059338671",
      to: "5059086351",
      body: "blah"
    })
  end
end
