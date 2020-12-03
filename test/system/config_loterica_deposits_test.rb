require "application_system_test_case"

class ConfigLotericaDepositsTest < ApplicationSystemTestCase
  setup do
    @config_loterica_deposit = config_loterica_deposits(:one)
  end

  test "visiting the index" do
    visit config_loterica_deposits_url
    assert_selector "h1", text: "Config Loterica Deposits"
  end

  test "creating a Config loterica deposit" do
    visit config_loterica_deposits_url
    click_on "New Config Loterica Deposit"

    fill_in "Prioridad max 1", with: @config_loterica_deposit.prioridad_max_1
    fill_in "Prioridad max 2", with: @config_loterica_deposit.prioridad_max_2
    fill_in "Prioridad max 3", with: @config_loterica_deposit.prioridad_max_3
    fill_in "Prioridad min 1", with: @config_loterica_deposit.prioridad_min_1
    fill_in "Prioridad min 2", with: @config_loterica_deposit.prioridad_min_2
    fill_in "Prioridad min 3", with: @config_loterica_deposit.prioridad_min_3
    click_on "Create Config loterica deposit"

    assert_text "Config loterica deposit was successfully created"
    click_on "Back"
  end

  test "updating a Config loterica deposit" do
    visit config_loterica_deposits_url
    click_on "Edit", match: :first

    fill_in "Prioridad max 1", with: @config_loterica_deposit.prioridad_max_1
    fill_in "Prioridad max 2", with: @config_loterica_deposit.prioridad_max_2
    fill_in "Prioridad max 3", with: @config_loterica_deposit.prioridad_max_3
    fill_in "Prioridad min 1", with: @config_loterica_deposit.prioridad_min_1
    fill_in "Prioridad min 2", with: @config_loterica_deposit.prioridad_min_2
    fill_in "Prioridad min 3", with: @config_loterica_deposit.prioridad_min_3
    click_on "Update Config loterica deposit"

    assert_text "Config loterica deposit was successfully updated"
    click_on "Back"
  end

  test "destroying a Config loterica deposit" do
    visit config_loterica_deposits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Config loterica deposit was successfully destroyed"
  end
end
