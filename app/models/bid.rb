class Bid
  include Mongoid::Document
  include Mongoid::Timestamps
  # before_create :check_bid_size

  belongs_to :nft_listing

  field :max_bid, type: Float
  field :email, type: String
  field :xrp_address, type: String

  # def check_bid_size
  #   if max_bid < nft_listing.minimum_bid
  #     raise "Bid Must"
  # end

end
