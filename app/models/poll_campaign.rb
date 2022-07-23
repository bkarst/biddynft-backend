class PollCampaign
  include Mongoid::Document
  include Mongoid::Timestamps
  field :duration, type: Integer
  field :chain, type: String
  field :start_time, type: DateTime
  field :end_time, type: DateTime
  belongs_to :poll
  has_many :poll_responses
end
