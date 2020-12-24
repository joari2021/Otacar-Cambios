require "application_system_test_case"

class AvalaibleBanksTest < ApplicationSystemTestCase
  setup do
    @avalaible_bank = avalaible_banks(:one)
  end

  test "visiting the index" do
    visit avalaible_banks_url
    assert_selector "h1", text: "Avalaible Banks"
  end

  test "creating a Avalaible bank" do
    visit avalaible_banks_url
    click_on "New Avalaible Bank"

    fill_in "Bank", with: @avalaible_bank.bank
    click_on "Create Avalaible bank"

    assert_text "Avalaible bank was successfully created"
    click_on "Back"
  end

  test "updating a Avalaible bank" do
    visit avalaible_banks_url
    click_on "Edit", match: :first

    fill_in "Bank", with: @avalaible_bank.bank
    click_on "Update Avalaible bank"

    assert_text "Avalaible bank was successfully updated"
    click_on "Back"
  end

  test "destroying a Avalaible bank" do
    visit avalaible_banks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Avalaible bank was successfully destroyed"
  end
end
