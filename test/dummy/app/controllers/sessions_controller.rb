class SessionsController < ApplicationController
  skip_before_action :require_accepted_agreements!

  def create
    session[:user_id] = params[:user_id]
    redirect_to root_path
  end
end
