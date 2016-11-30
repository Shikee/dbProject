require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get category" do
    get admin_category_url
    assert_response :success
  end

  test "should get mentorgroup" do
    get admin_mentorgroup_url
    assert_response :success
  end

end
