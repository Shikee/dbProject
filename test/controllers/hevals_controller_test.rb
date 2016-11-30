require 'test_helper'

class HevalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heval = hevals(:one)
  end

  test "should get index" do
    get hevals_url
    assert_response :success
  end

  test "should get new" do
    get new_heval_url
    assert_response :success
  end

  test "should create heval" do
    assert_difference('Heval.count') do
      post hevals_url, params: { heval: {  } }
    end

    assert_redirected_to heval_url(Heval.last)
  end

  test "should show heval" do
    get heval_url(@heval)
    assert_response :success
  end

  test "should get edit" do
    get edit_heval_url(@heval)
    assert_response :success
  end

  test "should update heval" do
    patch heval_url(@heval), params: { heval: {  } }
    assert_redirected_to heval_url(@heval)
  end

  test "should destroy heval" do
    assert_difference('Heval.count', -1) do
      delete heval_url(@heval)
    end

    assert_redirected_to hevals_url
  end
end
