class HomeController < ApplicationController
  def index
    render plain: "Welcome home"
  end
end
