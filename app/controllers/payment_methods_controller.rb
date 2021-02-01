class PaymentMethodsController < ApplicationController
  before_action :authenticate_normal_user!
  before_action :authenticate_user!
  def index
  end

  def set_method
  end
end
