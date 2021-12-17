class Api::NftListingController < ApplicationController

    def index
        @nft_listings = NftListing.all
        render :json => @nft_listings.to_json(:methods => [:minimum_bid_number, :current_bid, :bids, :auction_ended])
    end

    def show 
        @nft_listing = NftListing.where(id: params[:id])
        
        if @nft_listing.present?
            render :json => @nft_listing.to_json(:methods => [:minimum_bid_number, :current_bid, :bids, :auction_ended] )
        else
            render :json => {}
        end
    end

end
