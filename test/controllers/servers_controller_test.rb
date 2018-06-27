require 'test_helper'

class ServersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get servers_index_url
    assert_response :success
  end

  test "should get delete" do
    get servers_delete_url
    assert_response :success
  end

  test "should get edit" do
    get servers_edit_url
    assert_response :success
  end

  test "should get new" do
    get servers_new_url
    assert_response :success
  end

  test "should get show" do
    get servers_show_url
    assert_response :success
  end

end
