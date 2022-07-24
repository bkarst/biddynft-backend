class PollCampaign
  include Mongoid::Document
  include Mongoid::Timestamps
  field :duration, type: Integer
  field :chain, type: String
  field :start_time, type: DateTime
  field :end_time, type: DateTime
  belongs_to :poll
  has_many :poll_responses

  def to_hash
    {
      duration: duration, 
      chain: chain, 
      start_time: start_time,
      id: id.to_s,
      poll_id: poll.id.to_s,
      poll_responses: poll_responses.map{ |x| x.to_hash }
    }
  end

  def to_user_hash
    {
      id: id.to_s,
      duration: duration,
      chain: chain,
      start_time: start_time,
      poll: poll.to_user_hash,
    }
  end

end
