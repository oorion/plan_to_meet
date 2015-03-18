class Api::V1::UsersController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with User.all
  end

  def show
    user = User.find(params[:id])
    recommended_events = user.recommend_events
    respond_with recommended_events
  end
end
