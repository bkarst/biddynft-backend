class Api::PollsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_api_poll, only: %i[ show update destroy ]

  # GET /api/polls
  # GET /api/polls.json
  def index
    @api_polls = Poll.all
    # poll_options = PollOption.where(poll: @api_poll)
    
    render :json => @api_polls.map{|x| x.to_hash }
  end

  # GET /api/polls/1
  # GET /api/polls/1.json
  def show
    @api_poll = Poll.find(params[:id])
    # poll_options = PollOption.where(poll: @api_poll)
    render :json => @api_poll.to_hash
  end

  # POST /api/polls
  # POST /api/polls.json
  def create
    
    # p = Poll.create(:title => "poll name", :chain => "juno", :duration => 50)
    # po1 = PollOption.create(:description => "des1", :poll_order => 1, :poll => p)
    # po2 = PollOption.create(:description => "des2", :poll_order => 2, :poll => p)
    # po3 = PollOption.create(:description => "des3", :poll_order => 3, :poll => p)
    # po4 = PollOption.create(:description => "des4", :poll_order => 4, :poll => p)
    @api_poll = Poll.create(title: params[:title], chain: 'juno')
    # binding.pry
    render :json => @api_poll.to_hash
    
  end

  # PATCH/PUT /api/polls/1
  # PATCH/PUT /api/polls/1.json
  def update
    if @api_poll.update(api_poll_params)
      render :json => @api_poll.to_hash
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
      @api_poll = Poll.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_poll_params
      params.fetch(:api_poll, {})
    end
end
