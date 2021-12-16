class Bid
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :nft_listing
  field :max_bid, type: Float
  field :email, type: String
  field :xrp_address, type: String
end
