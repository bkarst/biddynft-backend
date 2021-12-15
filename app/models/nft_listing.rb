class NftListing
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  field :title, type: String
  field :image_url, type: String
  field :author_image_url, type: String
  field :auction_end_time, type: DateTime
  field :auction_start_time, type: DateTime
  field :reserve_price, type: Integer
  field :minimum_bid, type: Integer
  field :listing_type, type: String
  field :price, type: Integer
end
