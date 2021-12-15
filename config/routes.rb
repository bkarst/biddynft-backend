Rails.application.routes.draw do
  resources :nft_listings
  resources :nfts
  resources :bids
  scope '/api' do
    get '/nft_listings', to: 'api/nft_listing#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
