class NftListingsController < ApplicationController
  before_action :set_nft_listing, only: %i[ show edit update destroy ]

  # GET /nft_listings or /nft_listings.json
  def index
    @nft_listings = NftListing.all
  end

  # GET /nft_listings/1 or /nft_listings/1.json
  def show
    
  end

  # GET /nft_listings/new
  def new
    @nft_listing = NftListing.new
  end

  # GET /nft_listings/1/edit
  def edit
  end

  def start_time_value(params)
    if params["nft_listing"]
      DateTime.new(params["nft_listing"]["auction_start_time(1i)"].to_i, params["nft_listing"]["auction_start_time(2i)"].to_i, params["nft_listing"]["auction_start_time(3i)"].to_i, params["nft_listing"]["auction_start_time(4i)"].to_i, params["nft_listing"]["auction_start_time(5i)"].to_i)
    else 
      DateTime.new(params["auction_start_time(1i)"].to_i, params["auction_start_time(2i)"].to_i, params["auction_start_time(3i)"].to_i, params["auction_start_time(4i)"].to_i, params["auction_start_time(5i)"].to_i)
    end
  end

  def end_time_value(params)
    if params["nft_listing"]
      DateTime.new(params["nft_listing"]["auction_end_time(1i)"].to_i, params["nft_listing"]["auction_end_time(2i)"].to_i, params["nft_listing"]["auction_end_time(3i)"].to_i, params["nft_listing"]["auction_end_time(4i)"].to_i, params["nft_listing"]["auction_end_time(5i)"].to_i)
    else 
      DateTime.new(params["auction_end_time(1i)"].to_i, params["auction_end_time(2i)"].to_i, params["auction_end_time(3i)"].to_i, params["auction_end_time(4i)"].to_i, params["auction_end_time(5i)"].to_i)
    end
  end

  # POST /nft_listings or /nft_listings.json
  def create
    @nft_listing = NftListing.new(nft_listing_params)
    @nft_listing.auction_start_time = start_time_value(nft_listing_params)
    @nft_listing.auction_end_time = end_time_value(nft_listing_params)

    respond_to do |format|
      if @nft_listing.save
        format.html { redirect_to @nft_listing, notice: "Nft listing was successfully created." }
        format.json { render :show, status: :created, location: @nft_listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nft_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nft_listings/1 or /nft_listings/1.json
  def update
    @nft_listing.auction_start_time = start_time_value(nft_listing_params)
    @nft_listing.auction_end_time = end_time_value(nft_listing_params)

    respond_to do |format|
      if @nft_listing.update(nft_listing_params)
        format.html { redirect_to @nft_listing, notice: "Nft listing was successfully updated." }
        format.json { render :show, status: :ok, location: @nft_listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nft_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nft_listings/1 or /nft_listings/1.json
  def destroy
    @nft_listing.destroy
    respond_to do |format|
      format.html { redirect_to nft_listings_url, notice: "Nft listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nft_listing
      @nft_listing = NftListing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nft_listing_params
      params.require(:nft_listing).permit(:title, :currency, :image_url, :author_image_url, :auction_end_time, :auction_start_time, :reserve_price, :minimum_bid, :listing_type, :price, :description)
    end
end
