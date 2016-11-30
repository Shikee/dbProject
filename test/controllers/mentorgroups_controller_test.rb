require 'test_helper'

class MentorgroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mentorgroup = mentorgroups(:one)
  end

  test "should get index" do
    get mentorgroups_url
    assert_response :success
  end

  test "should get new" do
    get new_mentorgroup_url
    assert_response :success
  end

  test "should create mentorgroup" do
    assert_difference('Mentorgroup.count') do
      post mentorgroups_url, params: { mentorgroup: {  } }
    end

    assert_redirected_to mentorgroup_url(Mentorgroup.last)
  end

  test "should show mentorgroup" do
    get mentorgroup_url(@mentorgroup)
    assert_response :success
  end

  test "should get edit" do
    get edit_mentorgroup_url(@mentorgroup)
    assert_response :success
  end

  test "should update mentorgroup" do
    patch mentorgroup_url(@mentorgroup), params: { mentorgroup: {  } }
    assert_redirected_to mentorgroup_url(@mentorgroup)
  end

  test "should destroy mentorgroup" do
    assert_difference('Mentorgroup.count', -1) do
      delete mentorgroup_url(@mentorgroup)
    end

    assert_redirected_to mentorgroups_url
  end
end
