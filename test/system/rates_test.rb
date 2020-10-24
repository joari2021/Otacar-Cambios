require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
  setup do
    @rate = rates(:one)
  end

  test "visiting the index" do
    visit rates_url
    assert_selector "h1", text: "Rates"
  end

  test "creating a Rate" do
    visit rates_url
    click_on "New Rate"

    fill_in "Rate brasil", with: @rate.rate_brasil
    fill_in "Rate colombia", with: @rate.rate_colombia
    fill_in "Rate ecuador", with: @rate.rate_ecuador
    fill_in "Rate españa", with: @rate.rate_españa
    fill_in "Rate peru", with: @rate.rate_peru
    fill_in "Rate portugal", with: @rate.rate_portugal
    fill_in "Rate usa", with: @rate.rate_usa
    fill_in "Rate venezuela", with: @rate.rate_venezuela
    click_on "Create Rate"

    assert_text "Rate was successfully created"
    click_on "Back"
  end

  test "updating a Rate" do
    visit rates_url
    click_on "Edit", match: :first

    fill_in "Rate brasil", with: @rate.rate_brasil
    fill_in "Rate colombia", with: @rate.rate_colombia
    fill_in "Rate ecuador", with: @rate.rate_ecuador
    fill_in "Rate españa", with: @rate.rate_españa
    fill_in "Rate peru", with: @rate.rate_peru
    fill_in "Rate portugal", with: @rate.rate_portugal
    fill_in "Rate usa", with: @rate.rate_usa
    fill_in "Rate venezuela", with: @rate.rate_venezuela
    click_on "Update Rate"

    assert_text "Rate was successfully updated"
    click_on "Back"
  end

  test "destroying a Rate" do
    visit rates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rate was successfully destroyed"
  end
end
