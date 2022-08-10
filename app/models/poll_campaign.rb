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
  field :snapshot_taken_at, type: DateTime
  belongs_to :poll
  has_many :poll_responses

  CW_20_CONTRACT_ADDRESS = 'juno1rdw3gumdz7zyjn2pev9ugxs765xlv6vtv6g3jt2lqw580zrchvjs66daca'

  def self.execute_snapshots
    # poll_campaign = PollCampaign.where(status: 1).first
    poll_campaign = PollCampaign.where(snapshot_taken_at: nil, status: 1, :end_time.lte  => Time.now).first
    if poll_campaign.blank?
      return false
    end
    poll_campaign.poll_responses.each do |poll_response|
      encoded   = Base64.urlsafe_encode64(
        '{"balance":{"address":"' + poll_response.crypto_address + '"}}' )
      string = "https://api.juno.pupmos.network/cosmwasm/wasm/v1/contract/#{CW_20_CONTRACT_ADDRESS}/smart/" + encoded
      begin
      response = RestClient.get(string)
      parsed_response = JSON.parse(response)
      balance = parsed_response["data"]["balance"]
      poll_response.total_tokens_at_snapshot = balance
      poll_response.save
      rescue
        puts "Error in fetching balance"
      end
    end
    poll_campaign.snapshot_taken_at = Time.now
    poll_campaign.save
  end

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

  def results(prelim=true)
    if Time.now < end_time
      prelim = true
    else 
      prelim = false
    end
    total_weighted_votes = poll_responses.map{|x| 
        if prelim
          x.voting_balance.present? ? x.voting_balance : 0
        else 
          x.total_tokens_at_snapshot.present? ? x.total_tokens_at_snapshot : 0
        end
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
      if prelim
        x.voting_balance.present? ? x.voting_balance : 0
      else 
        x.total_tokens_at_snapshot.present? ? x.total_tokens_at_snapshot : 0
      end
      }.reduce(:+)
      weighted_percent = 0
      if weighted_votes && total_weighted_votes && total_weighted_votes > 0
        
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
        total_tokens_at_snapshot: total_tokens_at_snapshot,
        voting_balance: total_tokens_at_snapshot
        )
    end
  end

end
