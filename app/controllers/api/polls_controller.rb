class Api::PollsController < ApplicationController
  before_action :set_api_poll, only: %i[ show update destroy ]

  # GET /api/polls
  # GET /api/polls.json
  def index
    @api_polls = Api::Poll.all
  end

  # GET /api/polls/1
  # GET /api/polls/1.json
  def show
  end

  # POST /api/polls
  # POST /api/polls.json
  def create
    @api_poll = Api::Poll.new(api_poll_params)

    if @api_poll.save
      render :show, status: :created, location: @api_poll
    else
      render json: @api_poll.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/polls/1
  # PATCH/PUT /api/polls/1.json
  def update
    if @api_poll.update(api_poll_params)
      render :show, status: :ok, location: @api_poll
    else
      render json: @api_poll.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/polls/1
  # DELETE /api/polls/1.json
  def destroy
    @api_poll.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_poll
      @api_poll = Api::Poll.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_poll_params
      params.fetch(:api_poll, {})
    end
end
