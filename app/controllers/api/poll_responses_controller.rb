class Api::PollResponsesController < ApplicationController
  before_action :set_api_poll_response, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token
  

  # GET /api/poll_responses
  # GET /api/poll_responses.json
  def index
    @api_poll_responses = PollResponse.all
  end

  # GET /api/poll_responses/1
  # GET /api/poll_responses/1.json
  def show
  end

  # POST /api/poll_responses
  # POST /api/poll_responses.json
  def create

    @user = User.where(voting_key: params[:voting_key]).first

    if @user.blank?
      raise "Cannot find user"
    else
      if @user.crypto_address.blank?
        @other_address_holder = User.where(crypto_address: params[:address]).first
        if @other_address_holder.present?
          raise "This address has already been registered with another email."
        end
        @user.crypto_address = params[:address]
        @user.save
      end
    end

    @api_poll_response = PollResponse.new(
      crypto_address: @user.crypto_address,
      poll_option_id: params[:poll_option_id],
      poll_campaign_id: params[:poll_campaign_id],
      voting_balance: params[:voting_balance],
      user: @user
    )
    
    active_poll = PollCampaign.where(
      :start_time.lte => Time.now, 
      :end_time.gte => Time.now, 
      id: params[:poll_campaign_id]
    ).first
    
    @previous_response = PollResponse.where(
      crypto_address: @user.crypto_address,
      poll_campaign_id: params[:poll_campaign_id],
      user: @user
    ).first

    if @previous_response
      @previous_response.poll_option_id = params[:poll_option_id]
      @previous_response.voting_balance = params[:voting_balance]
      @api_poll_response = @previous_response
    end

    #check if voted already, 
    #check to see if the timestamp is within poll start and end time. 
    if active_poll && @api_poll_response.save
      render json: @api_poll_response
    elsif !active_poll
      render json: {error: "Current Poll not active"}
    else
      render json: @api_poll_response.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/poll_responses/1
  # PATCH/PUT /api/poll_responses/1.json
  def update
    if @api_poll_response.update(api_poll_response_params)
      render :show, status: :ok, location: @api_poll_response
    else
      render json: @api_poll_response.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/poll_responses/1
  # DELETE /api/poll_responses/1.json
  def destroy
    @api_poll_response.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_poll_response
      @api_poll_response = PollResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_poll_response_params
      params.fetch(:api_poll_response, {})
    end
end
