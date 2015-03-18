module UserMessaging
  def send_initial_text
    message = "Welcome to Plan To Meet.  We will send " +
        "your initial meetup suggestions soon."
    send_text(phone_number, message)
  end

  def send_top_recommendation_text
      message = recommend_events.first
    send_text(phone_number, message)
  end

  private

  def send_text(phone_number, message)
    twilio_sid = ENV["TWILIO_SID"]
    twilio_auth_token = ENV["TWILIO_AUTH_TOKEN"]
    @client = Twilio::REST::Client.new twilio_sid, twilio_auth_token
    @client.account.messages.create({
      from: "+15059338671",
      to: phone_number,
      body: message
    })
  end
end
