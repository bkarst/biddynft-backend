require 'test_helper'

class Api::PollCampaignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_poll_campaign = api_poll_campaigns(:one)
  end

  test "should get index" do
    get api_poll_campaigns_url, as: :json
    assert_response :success
  end

  test "should create api_poll_campaign" do
    assert_difference('Api::PollCampaign.count') do
      post api_poll_campaigns_url, params: { api_poll_campaign: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_poll_campaign" do
    get api_poll_campaign_url(@api_poll_campaign), as: :json
    assert_response :success
  end

  test "should update api_poll_campaign" do
    patch api_poll_campaign_url(@api_poll_campaign), params: { api_poll_campaign: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_poll_campaign" do
    assert_difference('Api::PollCampaign.count', -1) do
      delete api_poll_campaign_url(@api_poll_campaign), as: :json
    end

    assert_response 204
  end
end
