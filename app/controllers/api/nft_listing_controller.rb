class Api::NftListingController < ApplicationController

    def index
        @nft_listings = NftListing.all
        render :json => @nft_listings
    end
end
