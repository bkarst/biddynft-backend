class Api::PollCampaignsController < ApplicationController
  before_action :set_api_poll_campaign, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /api/poll_campaigns
  # GET /api/poll_campaigns.json
  def index
    @api_poll_campaigns = PollCampaign.all
  end

  # GET /api/poll_campaigns/1
  # GET /api/poll_campaigns/1.json
  def show
  end

  # POST /api/poll_campaigns
  # POST /api/poll_campaigns.json
  def create

    poll = Poll.find(params[:poll_id])
  

    conflicts = PollCampaign.where(status: 1, :start_time.lte => Time.parse(params[:start_time]), :end_time.gte => Time.parse(params[:start_time]))

    if conflicts.count === 0
      @api_poll_campaign = PollCampaign.new(poll: poll, duration: params[:duration],
      start_time: params[:start_time] )
      @api_poll_campaign.end_time = @api_poll_campaign.start_time + @api_poll_campaign.duration.hours
    end

    if conflicts.count > 0
      render json: {error: "date conflict"}
    elsif @api_poll_campaign && @api_poll_campaign.save
      render :json => @api_poll_campaign.to_hash
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
      @api_poll_campaign = PollCampaign.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_poll_campaign_params
      params.fetch(:api_poll_campaign, {})
    end
end
