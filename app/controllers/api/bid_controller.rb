class Api::BidController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        @bid = Bid.new(bid_params)
        @nft_listing = NftListing.find(params[:nft_listing_id])
        @bid.nft_listing = @nft_listing
          if @bid.save
            binding.pry
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
