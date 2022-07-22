require 'test_helper'

class Api::PollResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_poll_response = api_poll_responses(:one)
  end

  test "should get index" do
    get api_poll_responses_url, as: :json
    assert_response :success
  end

  test "should create api_poll_response" do
    assert_difference('Api::PollResponse.count') do
      post api_poll_responses_url, params: { api_poll_response: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_poll_response" do
    get api_poll_response_url(@api_poll_response), as: :json
    assert_response :success
  end

  test "should update api_poll_response" do
    patch api_poll_response_url(@api_poll_response), params: { api_poll_response: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_poll_response" do
    assert_difference('Api::PollResponse.count', -1) do
      delete api_poll_response_url(@api_poll_response), as: :json
    end

    assert_response 204
  end
end
