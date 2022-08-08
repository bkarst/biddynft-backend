class PollResponsesController < ApplicationController
  
  before_action :set_poll_response, only: %i[ show edit update destroy ]
  

  # GET /poll_responses or /poll_responses.json
  def index
    @poll_responses = PollResponse.all
  end

  # GET /poll_responses/1 or /poll_responses/1.json
  def show
  end

  # GET /poll_responses/new
  def new
    @poll_response = PollResponse.new
  end

  # GET /poll_responses/1/edit
  def edit
  end

  # POST /poll_responses or /poll_responses.json
  def create
    @poll_response = PollResponse.new(poll_response_params)
      if @poll_response.save
        render json: @poll_response
      else
        render json: @poll_response.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /poll_responses/1 or /poll_responses/1.json
  def update
    respond_to do |format|
      if @poll_response.update(poll_response_params)
        format.html { redirect_to @poll_response, notice: "Poll response was successfully updated." }
        format.json { render :show, status: :ok, location: @poll_response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @poll_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poll_responses/1 or /poll_responses/1.json
  def destroy
    @poll_response.destroy
    respond_to do |format|
      format.html { redirect_to poll_responses_url, notice: "Poll response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll_response
      @poll_response = PollResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def poll_response_params
      params.fetch(:poll_response, {})
    end
end
