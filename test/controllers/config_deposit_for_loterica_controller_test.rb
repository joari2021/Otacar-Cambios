require 'test_helper'

class ConfigDepositForLotericaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get config_deposit_for_loterica_index_url
    assert_response :success
  end
end
