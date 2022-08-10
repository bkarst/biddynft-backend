require 'test_helper'

class PollCampaignTest < ActiveSupport::TestCase

  setup do 
    duration = 1
    @my_poll = Poll.create(title: "My Poll",
    chain: 'juno',
    duration: duration)
    @poll_option1 = PollOption.create(poll: @my_poll, description: 'option 1', thumbnail_url: 'asdf1')
    @poll_option2 = PollOption.create(poll: @my_poll, description: 'option 2', thumbnail_url: 'asdf2')
    @poll_option3 = PollOption.create(poll: @my_poll, description: 'option 3', thumbnail_url: 'asdf2')
    @poll_campaign = PollCampaign.create(
      poll: @my_poll, duration: duration,
      start_time: Time.now - (duration + 1).hours, 
      end_time:  Time.now - (duration).hours, 
      )
    @poll_response1 = PollResponse.create(
      crypto_address: "juno15uv6hx0a6khw45fj29cavrxvfenq7z03k2ayyp", 
      voting_balance: 4000,
      poll_option: @poll_option3,
      poll_campaign: @poll_campaign
      )
      @poll_response2 = PollResponse.create(
      crypto_address: "juno15uv6hx0a6khw45fj29cavrxvfenq7z03k2asdf", 
      voting_balance: 4000,
      poll_option: @poll_option3,
      poll_campaign: @poll_campaign
      )

  end

  teardown do 
    Poll.delete_all
    PollOption.delete_all
    PollCampaign.delete_all
    PollResponse.delete_all
    assert Poll.count == 0
  end 

  test "the truth" do
    poll_campaign = PollCampaign.where(snapshot_taken_at: nil, status: 1, :end_time.lte  => Time.now).first
    PollCampaign.execute_snapshots
    assert(@poll_response1.reload.total_tokens_at_snapshot == 70000)
    assert(@poll_response2.reload.total_tokens_at_snapshot == nil)
    assert(@poll_campaign.reload.snapshot_taken_at != nil)
    snapshot_response = PollCampaign.execute_snapshots
    assert(snapshot_response == false)
    poll_campaign2 = PollCampaign.where(snapshot_taken_at: nil, status: 1, :end_time.lte  => Time.now).first
    assert(poll_campaign2 == nil)
  end
end
