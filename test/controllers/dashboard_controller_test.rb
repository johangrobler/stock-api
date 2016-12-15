require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get summary" do
    get dashboard_summary_url
    assert_response :success
  end

end
