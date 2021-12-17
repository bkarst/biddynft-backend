class Api::NftListingController < ApplicationController

    def index
        @nft_listings = NftListing.all
        render :json => @nft_listings
    end

    def show 
        @nft_listing = NftListing.where(id: params[:id])
        
        if @nft_listing.present?
            render :json => @nft_listing.to_json(:methods => [:minimum_bid_number, :bids] )
        else
            render :json => {}
        end
    end

end
