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
      end_time: end_time,
      id: id.to_s,
      poll_id: poll.id.to_s,
      poll_responses: poll_responses.map{ |x| x.to_hash },
      is_next_poll: is_next_poll,
      is_current_poll: is_current_poll,
      total_responses: poll_responses.count,
    }
  end

  def results
    total_weighted_votes = poll_responses.map{|x| 
        x.total_tokens_at_snapshot.present? ? x.total_tokens_at_snapshot : 0
      }.reduce(:+)
    results = {
      total_votes: poll_responses.count, 
      total_weighted_votes: total_weighted_votes, 
    }
    poll_option_results = []
    poll.poll_options.where(status: 1).each do |poll_option|
      poll_option_descrpition = poll_option.description
      poll_responses = self.poll_responses.where(poll_option: poll_option)
      vote_count = poll_responses.count
      weighted_votes = poll_responses.map{|x| 
        x.total_tokens_at_snapshot.present? ? x.total_tokens_at_snapshot : 0
      }.reduce(:+)
      weighted_percent = 0
      if weighted_votes
        weighted_percent = ((weighted_votes.to_f/total_weighted_votes.to_f)*100).round
      end
      hash = {description: poll_option_descrpition, 
        vote_count: vote_count, 
        weighted_votes: weighted_votes,
        weighted_percent: weighted_percent
      }
      poll_option_results << hash
    end
    results[:poll_options] = poll_option_results
    results
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

  def generate_data
    100.times do |index|
      crypto_address = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      selected_poll_option = poll.poll_options.where(status: 1).shuffle.first
      total_tokens_at_snapshot = 1000 + rand(30000)
      #crypto_address,total_tokens_at_snapshot, poll_option
      pr = PollResponse.create(
        poll_campaign: self, 
        crypto_address: crypto_address, 
        poll_option: selected_poll_option, 
        total_tokens_at_snapshot: total_tokens_at_snapshot
        )
    end
  end

end
