require "application_system_test_case"

class MobilePaymentsTest < ApplicationSystemTestCase
  setup do
    @mobile_payment = mobile_payments(:one)
  end

  test "visiting the index" do
    visit mobile_payments_url
    assert_selector "h1", text: "Mobile Payments"
  end

  test "creating a Mobile payment" do
    visit mobile_payments_url
    click_on "New Mobile Payment"

    fill_in "Bank", with: @mobile_payment.bank
    fill_in "Country", with: @mobile_payment.country
    fill_in "Document", with: @mobile_payment.document
    fill_in "Number phone", with: @mobile_payment.number_phone
    click_on "Create Mobile payment"

    assert_text "Mobile payment was successfully created"
    click_on "Back"
  end

  test "updating a Mobile payment" do
    visit mobile_payments_url
    click_on "Edit", match: :first

    fill_in "Bank", with: @mobile_payment.bank
    fill_in "Country", with: @mobile_payment.country
    fill_in "Document", with: @mobile_payment.document
    fill_in "Number phone", with: @mobile_payment.number_phone
    click_on "Update Mobile payment"

    assert_text "Mobile payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Mobile payment" do
    visit mobile_payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mobile payment was successfully destroyed"
  end
end
