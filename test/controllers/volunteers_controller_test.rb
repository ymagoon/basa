require 'test_helper'

class VolunteersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get volunteers_index_url
    assert_response :success
  end

  test "should get show" do
    get volunteers_show_url
    assert_response :success
  end

  test "should get new" do
    get volunteers_new_url
    assert_response :success
  end

  test "should get create" do
    get volunteers_create_url
    assert_response :success
  end

end
