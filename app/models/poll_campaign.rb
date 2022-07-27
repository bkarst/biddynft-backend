class PollCampaign
  attr_accessor :is_current_poll
  attr_accessor :is_next_poll

  include Mongoid::Document
  include Mongoid::Timestamps
  field :duration, type: Integer
  field :status, type: Integer, default: 1
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
      poll_responses: poll_responses.map{ |x| x.to_hash },
      is_next_poll: is_next_poll,
      is_current_poll: is_current_poll,
    }
  end

  def to_user_hash
    {
      id: id.to_s,
      duration: duration,
      chain: chain,
      start_time: start_time,
      end_time: end_time,
      poll: poll.to_user_hash,
      is_next_poll: is_next_poll,
      is_current_poll: is_current_poll,
    }
  end

end
