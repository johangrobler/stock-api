require 'test_helper'

class StockTakesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_take = stock_takes(:one)
  end

  test "should get index" do
    get stock_takes_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_take_url
    assert_response :success
  end

  test "should create stock_take" do
    assert_difference('StockTake.count') do
      post stock_takes_url, params: { stock_take: { clinic_id: @stock_take.clinic_id, latitude: @stock_take.latitude, longitude: @stock_take.longitude, product_id: @stock_take.product_id, quantity: @stock_take.quantity } }
    end

    assert_redirected_to stock_take_url(StockTake.last)
  end

  test "should show stock_take" do
    get stock_take_url(@stock_take)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_take_url(@stock_take)
    assert_response :success
  end

  test "should update stock_take" do
    patch stock_take_url(@stock_take), params: { stock_take: { clinic_id: @stock_take.clinic_id, latitude: @stock_take.latitude, longitude: @stock_take.longitude, product_id: @stock_take.product_id, quantity: @stock_take.quantity } }
    assert_redirected_to stock_take_url(@stock_take)
  end

  test "should destroy stock_take" do
    assert_difference('StockTake.count', -1) do
      delete stock_take_url(@stock_take)
    end

    assert_redirected_to stock_takes_url
  end
end
