class PollResponse
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :poll_option
  belongs_to :poll_campaign
  field :crypto_address, type: String
  field :total_tokens_at_snapshot, type: String
end
