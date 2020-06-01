require 'test_helper'

class BoardStatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get board_stats_index_url
    assert_response :success
  end

end
