require 'test_helper'

class MobilePaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mobile_payment = mobile_payments(:one)
  end

  test "should get index" do
    get mobile_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_mobile_payment_url
    assert_response :success
  end

  test "should create mobile_payment" do
    assert_difference('MobilePayment.count') do
      post mobile_payments_url, params: { mobile_payment: { bank: @mobile_payment.bank, country: @mobile_payment.country, document: @mobile_payment.document, number_phone: @mobile_payment.number_phone } }
    end

    assert_redirected_to mobile_payment_url(MobilePayment.last)
  end

  test "should show mobile_payment" do
    get mobile_payment_url(@mobile_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_mobile_payment_url(@mobile_payment)
    assert_response :success
  end

  test "should update mobile_payment" do
    patch mobile_payment_url(@mobile_payment), params: { mobile_payment: { bank: @mobile_payment.bank, country: @mobile_payment.country, document: @mobile_payment.document, number_phone: @mobile_payment.number_phone } }
    assert_redirected_to mobile_payment_url(@mobile_payment)
  end

  test "should destroy mobile_payment" do
    assert_difference('MobilePayment.count', -1) do
      delete mobile_payment_url(@mobile_payment)
    end

    assert_redirected_to mobile_payments_url
  end
end
