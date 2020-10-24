class HomeController < ApplicationController
  before_action :authenticate_normal_user!
  def index
    @rates = Rate.all
  end
  
end
