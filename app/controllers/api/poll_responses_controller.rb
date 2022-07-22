class Api::PollResponsesController < ApplicationController
  before_action :set_api_poll_response, only: %i[ show update destroy ]

  # GET /api/poll_responses
  # GET /api/poll_responses.json
  def index
    @api_poll_responses = Api::PollResponse.all
  end

  # GET /api/poll_responses/1
  # GET /api/poll_responses/1.json
  def show
  end

  # POST /api/poll_responses
  # POST /api/poll_responses.json
  def create
    @api_poll_response = Api::PollResponse.new(api_poll_response_params)

    if @api_poll_response.save
      render :show, status: :created, location: @api_poll_response
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
      @api_poll_response = Api::PollResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_poll_response_params
      params.fetch(:api_poll_response, {})
    end
end
