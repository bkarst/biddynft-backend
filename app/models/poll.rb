class Poll
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :chain, type: String
  field :duration, type: Integer
  field :status, type: Integer, default: 1

  has_many :poll_options
  has_many :poll_campaigns
  
  def to_detail_hash
    {
      id: self.id.to_s, 
      title: self.title,
      chain: self.chain,
      duration: self.duration,
      status: self.status,
      poll_options: poll_options.where(status: 1).map{|x| x.to_hash },
      poll_campaigns: poll_campaigns.map{|x| x.to_hash.merge({:results => x.results}) }
    }
  end

  def to_hash
    {
      id: self.id.to_s, 
      title: self.title,
      chain: self.chain,
      duration: self.duration,
      status: self.status,
      poll_options: poll_options.where(status: 1).map{|x| x.to_hash },
      poll_campaigns: poll_campaigns.map{|x| x.to_hash }
    }
  end

  

  def to_user_hash
    {
      id: self.id.to_s, 
      title: self.title,
      chain: self.chain,
      duration: self.duration,
      status: self.status,
      poll_options: poll_options.where(status: 1).map{|x| x.to_hash }
    }
  end

  

  # def with_poll_options
  #   poll_options
  # end

end
