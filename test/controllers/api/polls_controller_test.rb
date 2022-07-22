require 'test_helper'

class Api::PollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_poll = api_polls(:one)
  end

  test "should get index" do
    get api_polls_url, as: :json
    assert_response :success
  end

  test "should create api_poll" do
    assert_difference('Api::Poll.count') do
      post api_polls_url, params: { api_poll: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_poll" do
    get api_poll_url(@api_poll), as: :json
    assert_response :success
  end

  test "should update api_poll" do
    patch api_poll_url(@api_poll), params: { api_poll: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_poll" do
    assert_difference('Api::Poll.count', -1) do
      delete api_poll_url(@api_poll), as: :json
    end

    assert_response 204
  end
end
