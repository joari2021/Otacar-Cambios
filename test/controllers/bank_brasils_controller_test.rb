require 'test_helper'

class BankBrasilsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank_brasil = bank_brasils(:one)
  end

  test "should get index" do
    get bank_brasils_url
    assert_response :success
  end

  test "should get new" do
    get new_bank_brasil_url
    assert_response :success
  end

  test "should create bank_brasil" do
    assert_difference('BankBrasil.count') do
      post bank_brasils_url, params: { bank_brasil: { country: @bank_brasil.country, cpf: @bank_brasil.cpf, last_name: @bank_brasil.last_name, name: @bank_brasil.name, number_account: @bank_brasil.number_account, number_agency: @bank_brasil.number_agency } }
    end

    assert_redirected_to bank_brasil_url(BankBrasil.last)
  end

  test "should show bank_brasil" do
    get bank_brasil_url(@bank_brasil)
    assert_response :success
  end

  test "should get edit" do
    get edit_bank_brasil_url(@bank_brasil)
    assert_response :success
  end

  test "should update bank_brasil" do
    patch bank_brasil_url(@bank_brasil), params: { bank_brasil: { country: @bank_brasil.country, cpf: @bank_brasil.cpf, last_name: @bank_brasil.last_name, name: @bank_brasil.name, number_account: @bank_brasil.number_account, number_agency: @bank_brasil.number_agency } }
    assert_redirected_to bank_brasil_url(@bank_brasil)
  end

  test "should destroy bank_brasil" do
    assert_difference('BankBrasil.count', -1) do
      delete bank_brasil_url(@bank_brasil)
    end

    assert_redirected_to bank_brasils_url
  end
end
