class Bid
  include Mongoid::Document
  include Mongoid::Timestamps
  field :belongs_to, type: NftListing
  field :max_bid, type: Float
  field :email, type: String
  field :xrp_address, type: String
end
