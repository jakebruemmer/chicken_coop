require "test_helper"

class CoopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coop = coops(:one)
  end

  test "should get index" do
    get coops_url
    assert_response :success
  end

  test "should get new" do
    get new_coop_url
    assert_response :success
  end

  test "should create coop" do
    assert_difference("Coop.count") do
      post coops_url, params: { coop: { name: @coop.name } }
    end

    assert_redirected_to coop_url(Coop.last)
  end

  test "should show coop" do
    get coop_url(@coop)
    assert_response :success
  end

  test "should get edit" do
    get edit_coop_url(@coop)
    assert_response :success
  end

  test "should update coop" do
    patch coop_url(@coop), params: { coop: { name: @coop.name } }
    assert_redirected_to coop_url(@coop)
  end

  test "should destroy coop" do
    assert_difference("Coop.count", -1) do
      delete coop_url(@coop)
    end

    assert_redirected_to coops_url
  end
end
