require 'test_helper'

class StudentRostersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get student_rosters_create_url
    assert_response :success
  end

end
