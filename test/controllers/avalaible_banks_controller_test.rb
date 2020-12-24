require 'test_helper'

class AvalaibleBanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @avalaible_bank = avalaible_banks(:one)
  end

  test "should get index" do
    get avalaible_banks_url
    assert_response :success
  end

  test "should get new" do
    get new_avalaible_bank_url
    assert_response :success
  end

  test "should create avalaible_bank" do
    assert_difference('AvalaibleBank.count') do
      post avalaible_banks_url, params: { avalaible_bank: { bank: @avalaible_bank.bank } }
    end

    assert_redirected_to avalaible_bank_url(AvalaibleBank.last)
  end

  test "should show avalaible_bank" do
    get avalaible_bank_url(@avalaible_bank)
    assert_response :success
  end

  test "should get edit" do
    get edit_avalaible_bank_url(@avalaible_bank)
    assert_response :success
  end

  test "should update avalaible_bank" do
    patch avalaible_bank_url(@avalaible_bank), params: { avalaible_bank: { bank: @avalaible_bank.bank } }
    assert_redirected_to avalaible_bank_url(@avalaible_bank)
  end

  test "should destroy avalaible_bank" do
    assert_difference('AvalaibleBank.count', -1) do
      delete avalaible_bank_url(@avalaible_bank)
    end

    assert_redirected_to avalaible_banks_url
  end
end
