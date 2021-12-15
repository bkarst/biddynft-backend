json.extract! nft_listing, :id, :title, :image_url, :author_image_url, :auction_end_time, :auction_start_time, :reserve_price, :minimum_bid, :listing_type, :price, :created_at, :updated_at
json.url nft_listing_url(nft_listing, format: :json)
