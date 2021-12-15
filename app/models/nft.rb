class Nft
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :image_url, type: String
  field :supply, type: Integer
  field :author_image_url, type: String
end
