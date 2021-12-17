class Api::BidController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        @bid = Bid.new(bid_params)
        @nft_listing = NftListing.find(params[:nft_listing_id])
        # elsif @bid.max_bid && @nft_listing.bids.length > 0
        # end
        block = 5
        if @bid.max_bid < @nft_listing.minimum_bid_number + block
            @bid.nft_listing = @nft_listing
            render json: {error: "Bid size must must larger."}
        elsif @bid.save
            render :json => @bid
        else
            render json: @bid.errors, status: :unprocessable_entity
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bid_params
      params.require(:bid).permit(:belongs_to, :max_bid, :email, :xrp_address, :nft_listing_id)
    end

end
