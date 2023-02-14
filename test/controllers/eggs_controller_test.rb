require "test_helper"

class EggsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @egg = eggs(:one)
  end

  test "should get index" do
    get eggs_url
    assert_response :success
  end

  test "should get new" do
    get new_egg_url
    assert_response :success
  end

  test "should create egg" do
    assert_difference("Egg.count") do
      post eggs_url, params: { egg: { color: @egg.color, fertilized: @egg.fertilized, laid: @egg.laid, weight_mg: @egg.weight_mg, weight_oz: @egg.weight_oz } }
    end

    assert_redirected_to egg_url(Egg.last)
  end

  test "should show egg" do
    get egg_url(@egg)
    assert_response :success
  end

  test "should get edit" do
    get edit_egg_url(@egg)
    assert_response :success
  end

  test "should update egg" do
    patch egg_url(@egg), params: { egg: { color: @egg.color, fertilized: @egg.fertilized, laid: @egg.laid, weight_mg: @egg.weight_mg, weight_oz: @egg.weight_oz } }
    assert_redirected_to egg_url(@egg)
  end

  test "should destroy egg" do
    assert_difference("Egg.count", -1) do
      delete egg_url(@egg)
    end

    assert_redirected_to eggs_url
  end
end
