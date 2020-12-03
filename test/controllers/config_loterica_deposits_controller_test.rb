require 'test_helper'

class ConfigLotericaDepositsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @config_loterica_deposit = config_loterica_deposits(:one)
  end

  test "should get index" do
    get config_loterica_deposits_url
    assert_response :success
  end

  test "should get new" do
    get new_config_loterica_deposit_url
    assert_response :success
  end

  test "should create config_loterica_deposit" do
    assert_difference('ConfigLotericaDeposit.count') do
      post config_loterica_deposits_url, params: { config_loterica_deposit: { prioridad_max_1: @config_loterica_deposit.prioridad_max_1, prioridad_max_2: @config_loterica_deposit.prioridad_max_2, prioridad_max_3: @config_loterica_deposit.prioridad_max_3, prioridad_min_1: @config_loterica_deposit.prioridad_min_1, prioridad_min_2: @config_loterica_deposit.prioridad_min_2, prioridad_min_3: @config_loterica_deposit.prioridad_min_3 } }
    end

    assert_redirected_to config_loterica_deposit_url(ConfigLotericaDeposit.last)
  end

  test "should show config_loterica_deposit" do
    get config_loterica_deposit_url(@config_loterica_deposit)
    assert_response :success
  end

  test "should get edit" do
    get edit_config_loterica_deposit_url(@config_loterica_deposit)
    assert_response :success
  end

  test "should update config_loterica_deposit" do
    patch config_loterica_deposit_url(@config_loterica_deposit), params: { config_loterica_deposit: { prioridad_max_1: @config_loterica_deposit.prioridad_max_1, prioridad_max_2: @config_loterica_deposit.prioridad_max_2, prioridad_max_3: @config_loterica_deposit.prioridad_max_3, prioridad_min_1: @config_loterica_deposit.prioridad_min_1, prioridad_min_2: @config_loterica_deposit.prioridad_min_2, prioridad_min_3: @config_loterica_deposit.prioridad_min_3 } }
    assert_redirected_to config_loterica_deposit_url(@config_loterica_deposit)
  end

  test "should destroy config_loterica_deposit" do
    assert_difference('ConfigLotericaDeposit.count', -1) do
      delete config_loterica_deposit_url(@config_loterica_deposit)
    end

    assert_redirected_to config_loterica_deposits_url
  end
end
