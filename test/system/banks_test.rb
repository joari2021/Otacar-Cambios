require "application_system_test_case"

class BanksTest < ApplicationSystemTestCase
  setup do
    @bank = banks(:one)
  end

  test "visiting the index" do
    visit banks_url
    assert_selector "h1", text: "Banks"
  end

  test "creating a Bank" do
    visit banks_url
    click_on "New Bank"

    fill_in "Bank", with: @bank.bank
    fill_in "Cod bank", with: @bank.cod_bank
    fill_in "Country", with: @bank.country
    fill_in "Identidy", with: @bank.identidy
    fill_in "Name", with: @bank.name
    fill_in "Number account", with: @bank.number_account
    fill_in "Phone", with: @bank.phone
    fill_in "State", with: @bank.state
    fill_in "Type account", with: @bank.type_account
    click_on "Create Bank"

    assert_text "Bank was successfully created"
    click_on "Back"
  end

  test "updating a Bank" do
    visit banks_url
    click_on "Edit", match: :first

    fill_in "Bank", with: @bank.bank
    fill_in "Cod bank", with: @bank.cod_bank
    fill_in "Country", with: @bank.country
    fill_in "Identidy", with: @bank.identidy
    fill_in "Name", with: @bank.name
    fill_in "Number account", with: @bank.number_account
    fill_in "Phone", with: @bank.phone
    fill_in "State", with: @bank.state
    fill_in "Type account", with: @bank.type_account
    click_on "Update Bank"

    assert_text "Bank was successfully updated"
    click_on "Back"
  end

  test "destroying a Bank" do
    visit banks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bank was successfully destroyed"
  end
end
