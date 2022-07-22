class Api::PollCampaignsController < ApplicationController
  before_action :set_api_poll_campaign, only: %i[ show update destroy ]

  # GET /api/poll_campaigns
  # GET /api/poll_campaigns.json
  def index
    @api_poll_campaigns = Api::PollCampaign.all
  end

  # GET /api/poll_campaigns/1
  # GET /api/poll_campaigns/1.json
  def show
  end

  # POST /api/poll_campaigns
  # POST /api/poll_campaigns.json
  def create
    @api_poll_campaign = Api::PollCampaign.new(api_poll_campaign_params)

    if @api_poll_campaign.save
      render :show, status: :created, location: @api_poll_campaign
    else
      render json: @api_poll_campaign.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/poll_campaigns/1
  # PATCH/PUT /api/poll_campaigns/1.json
  def update
    if @api_poll_campaign.update(api_poll_campaign_params)
      render :show, status: :ok, location: @api_poll_campaign
    else
      render json: @api_poll_campaign.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/poll_campaigns/1
  # DELETE /api/poll_campaigns/1.json
  def destroy
    @api_poll_campaign.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_poll_campaign
      @api_poll_campaign = Api::PollCampaign.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_poll_campaign_params
      params.fetch(:api_poll_campaign, {})
    end
end
