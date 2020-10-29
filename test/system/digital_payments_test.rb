require "application_system_test_case"

class DigitalPaymentsTest < ApplicationSystemTestCase
  setup do
    @digital_payment = digital_payments(:one)
  end

  test "visiting the index" do
    visit digital_payments_url
    assert_selector "h1", text: "Digital Payments"
  end

  test "creating a Digital payment" do
    visit digital_payments_url
    click_on "New Digital Payment"

    fill_in "Last name", with: @digital_payment.last_name
    fill_in "Name", with: @digital_payment.name
    fill_in "Number phone", with: @digital_payment.number_phone
    fill_in "Payment method", with: @digital_payment.payment_method
    click_on "Create Digital payment"

    assert_text "Digital payment was successfully created"
    click_on "Back"
  end

  test "updating a Digital payment" do
    visit digital_payments_url
    click_on "Edit", match: :first

    fill_in "Last name", with: @digital_payment.last_name
    fill_in "Name", with: @digital_payment.name
    fill_in "Number phone", with: @digital_payment.number_phone
    fill_in "Payment method", with: @digital_payment.payment_method
    click_on "Update Digital payment"

    assert_text "Digital payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Digital payment" do
    visit digital_payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Digital payment was successfully destroyed"
  end
end
