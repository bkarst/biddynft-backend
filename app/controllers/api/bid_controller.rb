class Api::BidController < ApplicationController

    def bid
        @bid = Bid.new(bid_params)
        respond_to do |format|
          if @bid.save
            render :json => @bid
          else
            format.json { render json: @bid.errors, status: :unprocessable_entity }
          end
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bid_params
      params.require(:bid).permit(:belongs_to, :amount, :email, :xrp_address)
    end

end
