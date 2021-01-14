class PaymentMethodsController < ApplicationController
  before_action :authenticate_normal_user!, except: [:pending]
  before_action :authenticate_user!
  def index
  end

  def set_method
  end
end
