class Api::PollOptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_api_poll_option, only: %i[ show edit update destroy inactivate ]

  # GET /api/poll_options or /api/poll_options.json
  def index
    @api_poll_options = PollOption.where(status: 1)
  end

  # GET /api/poll_options/1 or /api/poll_options/1.json
  def show
  end

  # GET /api/poll_options/new
  def new
    @api_poll_option = PollOption.new
  end

  # GET /api/poll_options/1/edit
  def edit
  end

  def inactivate
    @api_poll_option.status = 0
    @api_poll_option.save
    render :json => @api_poll_option.to_hash    
  end

  # POST /api/poll_options or /api/poll_options.json
  def create
    poll = Poll.find(params[:poll_id])
    @api_poll_option = PollOption.new(
      description: params[:description], 
      thumbnail_url: params[:thumbnail_url], 
      poll: poll)
    if @api_poll_option.save
      render :json => @api_poll_option.to_hash
    else
      render json: @api_poll_option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/poll_options/1 or /api/poll_options/1.json
  def update
      if @api_poll_option.update({ description: params[:description], thumbnail_url: params[:thumbnail_url] } )
        render json:  @api_poll_option.to_hash
      else
        render json: @api_poll_option.errors, status: :unprocessable_entity
      end
  end

  # DELETE /api/poll_options/1 or /api/poll_options/1.json
  def destroy
    @api_poll_option.destroy
    respond_to do |format|
      format.html { redirect_to api_poll_options_url, notice: "Poll option was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_poll_option
      @api_poll_option = PollOption.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_poll_option_params
      params.fetch(:api_poll_option, {})
    end
end
