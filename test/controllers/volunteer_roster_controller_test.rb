require 'test_helper'

class VolunteerRosterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get volunteer_roster_index_url
    assert_response :success
  end

  test "should get show" do
    get volunteer_roster_show_url
    assert_response :success
  end

  test "should get new" do
    get volunteer_roster_new_url
    assert_response :success
  end

  test "should get create" do
    get volunteer_roster_create_url
    assert_response :success
  end

  test "should get edit" do
    get volunteer_roster_edit_url
    assert_response :success
  end

  test "should get update" do
    get volunteer_roster_update_url
    assert_response :success
  end

  test "should get destroy" do
    get volunteer_roster_destroy_url
    assert_response :success
  end

end
