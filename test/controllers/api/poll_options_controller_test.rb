require 'test_helper'

class Api::PollOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_poll_option = api_poll_options(:one)
  end

  test "should get index" do
    get api_poll_options_url
    assert_response :success
  end

  test "should get new" do
    get new_api_poll_option_url
    assert_response :success
  end

  test "should create api_poll_option" do
    assert_difference('Api::PollOption.count') do
      post api_poll_options_url, params: { api_poll_option: {  } }
    end

    assert_redirected_to api_poll_option_url(Api::PollOption.last)
  end

  test "should show api_poll_option" do
    get api_poll_option_url(@api_poll_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_poll_option_url(@api_poll_option)
    assert_response :success
  end

  test "should update api_poll_option" do
    patch api_poll_option_url(@api_poll_option), params: { api_poll_option: {  } }
    assert_redirected_to api_poll_option_url(@api_poll_option)
  end

  test "should destroy api_poll_option" do
    assert_difference('Api::PollOption.count', -1) do
      delete api_poll_option_url(@api_poll_option)
    end

    assert_redirected_to api_poll_options_url
  end
end
