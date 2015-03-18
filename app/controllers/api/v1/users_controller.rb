class Api::V1::UsersController < ApplicationController
  respond_to :json, :xml

  def index
    all_users = User.all
    respond_with all_users
  end
end
