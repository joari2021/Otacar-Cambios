require 'test_helper'

class RatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate = rates(:one)
  end

  test "should get index" do
    get rates_url
    assert_response :success
  end

  test "should get new" do
    get new_rate_url
    assert_response :success
  end

  test "should create rate" do
    assert_difference('Rate.count') do
      post rates_url, params: { rate: { rate_brasil: @rate.rate_brasil, rate_colombia: @rate.rate_colombia, rate_ecuador: @rate.rate_ecuador, rate_españa: @rate.rate_españa, rate_peru: @rate.rate_peru, rate_portugal: @rate.rate_portugal, rate_usa: @rate.rate_usa, rate_venezuela: @rate.rate_venezuela } }
    end

    assert_redirected_to rate_url(Rate.last)
  end

  test "should show rate" do
    get rate_url(@rate)
    assert_response :success
  end

  test "should get edit" do
    get edit_rate_url(@rate)
    assert_response :success
  end

  test "should update rate" do
    patch rate_url(@rate), params: { rate: { rate_brasil: @rate.rate_brasil, rate_colombia: @rate.rate_colombia, rate_ecuador: @rate.rate_ecuador, rate_españa: @rate.rate_españa, rate_peru: @rate.rate_peru, rate_portugal: @rate.rate_portugal, rate_usa: @rate.rate_usa, rate_venezuela: @rate.rate_venezuela } }
    assert_redirected_to rate_url(@rate)
  end

  test "should destroy rate" do
    assert_difference('Rate.count', -1) do
      delete rate_url(@rate)
    end

    assert_redirected_to rates_url
  end
end
