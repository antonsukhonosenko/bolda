require 'test_helper'

class GameControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get join" do
    get :join
    assert_response :success
  end

  test "should get leave" do
    get :leave
    assert_response :success
  end

  test "should get finish" do
    get :finish
    assert_response :success
  end

  test "should get skipturn" do
    get :skipturn
    assert_response :success
  end

  test "should get newturn" do
    get :newturn
    assert_response :success
  end

end
