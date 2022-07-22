Rails.application.routes.draw do
  namespace :api do
    resources :poll_campaigns
  end
  namespace :api do
    resources :poll_responses
  end
  namespace :api do
    resources :polls
  end
  namespace :api do
    resources :poll_options
  end
  resources :nft_listings
  resources :nfts
  resources :bids
  scope '/api' do
    get '/nft_listings', to: 'api/nft_listing#index'
    get '/nft_listing/:id', to: 'api/nft_listing#show'
    post '/bid', to: 'api/bid#create'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
