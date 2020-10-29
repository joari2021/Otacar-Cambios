require "application_system_test_case"

class WalletWithUsersTest < ApplicationSystemTestCase
  setup do
    @wallet_with_user = wallet_with_users(:one)
  end

  test "visiting the index" do
    visit wallet_with_users_url
    assert_selector "h1", text: "Wallet With Users"
  end

  test "creating a Wallet with user" do
    visit wallet_with_users_url
    click_on "New Wallet With User"

    fill_in "Country", with: @wallet_with_user.country
    fill_in "Last name", with: @wallet_with_user.last_name
    fill_in "Name", with: @wallet_with_user.name
    fill_in "User", with: @wallet_with_user.user
    fill_in "Wallet name", with: @wallet_with_user.wallet_name
    click_on "Create Wallet with user"

    assert_text "Wallet with user was successfully created"
    click_on "Back"
  end

  test "updating a Wallet with user" do
    visit wallet_with_users_url
    click_on "Edit", match: :first

    fill_in "Country", with: @wallet_with_user.country
    fill_in "Last name", with: @wallet_with_user.last_name
    fill_in "Name", with: @wallet_with_user.name
    fill_in "User", with: @wallet_with_user.user
    fill_in "Wallet name", with: @wallet_with_user.wallet_name
    click_on "Update Wallet with user"

    assert_text "Wallet with user was successfully updated"
    click_on "Back"
  end

  test "destroying a Wallet with user" do
    visit wallet_with_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wallet with user was successfully destroyed"
  end
end
