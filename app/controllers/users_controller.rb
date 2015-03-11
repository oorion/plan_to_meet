class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    user.store_past_events
    #@recommended_events = user.recommend_events
  end
end
