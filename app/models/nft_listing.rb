class NftListing
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
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
end
