require_relative '../../lib/recommendation_engine'

class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    user.store_past_events
    @recommended_events = user.recommend_events
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Your contact information was updated"
    else
      flash[:alert] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :phone_number)
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
