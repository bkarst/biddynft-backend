json.extract! nft, :id, :title, :image_url, :supply, :author_image_url, :created_at, :updated_at
json.url nft_url(nft, format: :json)
