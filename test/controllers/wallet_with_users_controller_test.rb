require 'test_helper'

class WalletWithUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wallet_with_user = wallet_with_users(:one)
  end

  test "should get index" do
    get wallet_with_users_url
    assert_response :success
  end

  test "should get new" do
    get new_wallet_with_user_url
    assert_response :success
  end

  test "should create wallet_with_user" do
    assert_difference('WalletWithUser.count') do
      post wallet_with_users_url, params: { wallet_with_user: { country: @wallet_with_user.country, last_name: @wallet_with_user.last_name, name: @wallet_with_user.name, user: @wallet_with_user.user, wallet_name: @wallet_with_user.wallet_name } }
    end

    assert_redirected_to wallet_with_user_url(WalletWithUser.last)
  end

  test "should show wallet_with_user" do
    get wallet_with_user_url(@wallet_with_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_wallet_with_user_url(@wallet_with_user)
    assert_response :success
  end

  test "should update wallet_with_user" do
    patch wallet_with_user_url(@wallet_with_user), params: { wallet_with_user: { country: @wallet_with_user.country, last_name: @wallet_with_user.last_name, name: @wallet_with_user.name, user: @wallet_with_user.user, wallet_name: @wallet_with_user.wallet_name } }
    assert_redirected_to wallet_with_user_url(@wallet_with_user)
  end

  test "should destroy wallet_with_user" do
    assert_difference('WalletWithUser.count', -1) do
      delete wallet_with_user_url(@wallet_with_user)
    end

    assert_redirected_to wallet_with_users_url
  end
end
