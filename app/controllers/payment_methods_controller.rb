class PaymentMethodsController < ApplicationController
  before_action :authenticate_normal_user!, except: [:pending]
  def index
  end

  def set_method
    @bank = Bank.new
  end
end
