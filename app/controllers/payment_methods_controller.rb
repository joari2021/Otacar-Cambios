class PaymentMethodsController < ApplicationController
  def index
  end

  def set_method
    @bank = Bank.new
  end
end
