require "application_system_test_case"

class BankBrasilsTest < ApplicationSystemTestCase
  setup do
    @bank_brasil = bank_brasils(:one)
  end

  test "visiting the index" do
    visit bank_brasils_url
    assert_selector "h1", text: "Bank Brasils"
  end

  test "creating a Bank brasil" do
    visit bank_brasils_url
    click_on "New Bank Brasil"

    fill_in "Country", with: @bank_brasil.country
    fill_in "Cpf", with: @bank_brasil.cpf
    fill_in "Last name", with: @bank_brasil.last_name
    fill_in "Name", with: @bank_brasil.name
    fill_in "Number account", with: @bank_brasil.number_account
    fill_in "Number agency", with: @bank_brasil.number_agency
    click_on "Create Bank brasil"

    assert_text "Bank brasil was successfully created"
    click_on "Back"
  end

  test "updating a Bank brasil" do
    visit bank_brasils_url
    click_on "Edit", match: :first

    fill_in "Country", with: @bank_brasil.country
    fill_in "Cpf", with: @bank_brasil.cpf
    fill_in "Last name", with: @bank_brasil.last_name
    fill_in "Name", with: @bank_brasil.name
    fill_in "Number account", with: @bank_brasil.number_account
    fill_in "Number agency", with: @bank_brasil.number_agency
    click_on "Update Bank brasil"

    assert_text "Bank brasil was successfully updated"
    click_on "Back"
  end

  test "destroying a Bank brasil" do
    visit bank_brasils_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bank brasil was successfully destroyed"
  end
end
