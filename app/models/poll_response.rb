class PollResponse
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :poll_option
  belongs_to :poll_campaign
  field :crypto_address, type: String
  field :total_tokens_at_snapshot, type: String

  def to_hash
    { 
      crypto_address: crypto_address,
      total_tokens_at_snapshot:total_tokens_at_snapshot,
      poll_option_id: poll_option.id,
      poll_campaign_id: poll_campaign.id
    }
  end
end
