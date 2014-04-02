class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

end
