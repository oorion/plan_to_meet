class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    unless user.events?
      user.store_past_events
    end
    #@recommended_events = user.recommend_events
  end
end
