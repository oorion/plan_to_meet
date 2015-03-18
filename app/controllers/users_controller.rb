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
      phone_number = @user.phone_number
      @user.send_top_recommendation_text(phone_number)
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
end
