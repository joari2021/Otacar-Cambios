require 'test_helper'

class DigitalPaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @digital_payment = digital_payments(:one)
  end

  test "should get index" do
    get digital_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_digital_payment_url
    assert_response :success
  end

  test "should create digital_payment" do
    assert_difference('DigitalPayment.count') do
      post digital_payments_url, params: { digital_payment: { last_name: @digital_payment.last_name, name: @digital_payment.name, number_phone: @digital_payment.number_phone, payment_method: @digital_payment.payment_method } }
    end

    assert_redirected_to digital_payment_url(DigitalPayment.last)
  end

  test "should show digital_payment" do
    get digital_payment_url(@digital_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_digital_payment_url(@digital_payment)
    assert_response :success
  end

  test "should update digital_payment" do
    patch digital_payment_url(@digital_payment), params: { digital_payment: { last_name: @digital_payment.last_name, name: @digital_payment.name, number_phone: @digital_payment.number_phone, payment_method: @digital_payment.payment_method } }
    assert_redirected_to digital_payment_url(@digital_payment)
  end

  test "should destroy digital_payment" do
    assert_difference('DigitalPayment.count', -1) do
      delete digital_payment_url(@digital_payment)
    end

    assert_redirected_to digital_payments_url
  end
end
