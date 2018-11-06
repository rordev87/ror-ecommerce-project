require 'test_helper'

class WeaponControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get weapon_show_url
    assert_response :success
  end

  test "should get index" do
    get weapon_index_url
    assert_response :success
  end

end
