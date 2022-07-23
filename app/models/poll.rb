class Poll
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :chain, type: String
  field :duration, type: Integer
  field :status, type: Integer

  has_many :poll_options
  has_many :poll_campaigns
  
  def to_hash
    {
      id: self.id.to_s, 
      title: self.title,
      chain: self.chain,
      duration: self.duration,
      status: self.status,
      poll_options: poll_options.map{|x| x.to_hash }
    }
  end

  # def with_poll_options
  #   poll_options
  # end

end
