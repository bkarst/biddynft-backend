class NftListing
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  has_many :bids, :order => 'created_at DESC'

  field :title, type: String
  field :image_url, type: String
  field :author_image_url, type: String
  field :auction_end_time, type: DateTime
  field :auction_start_time, type: DateTime
  field :reserve_price, type: Float
  field :minimum_bid, type: Float
  field :listing_type, type: String
  field :price, type: Float
  field :currency, type: String, :default => 'XRP'
  field :description, type: String

  
  def to_hash
    {
      auction_end_time: auction_end_time, 
      auction_start_time: auction_start_time, 
    reserve_price: reserve_price,
    minimum_bid: minimum_bid,
    listing_type: listing_type,
    price: price,
    minimum_bid_number: minimum_bid_number,
  }
  end

  def minimum_bid_number
    if bids.length == 0
      if minimum_bid
        minimum_bid
      else
        0
      end
    else
      bids.sort_by{ |x| x.max_bid }.last.max_bid
    end
  end

end
