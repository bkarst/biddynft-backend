class Api::PollsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_api_poll, only: %i[ show update destroy inactivate]


  def current
    @api_poll = PollCampaign.where(status: 1, :start_time.lte => Time.now, :end_time.gte => Time.now).first
    
    # poll_options = PollOption.where(poll: @api_poll)
    if @api_poll
      @api_poll.is_current_poll = true
    else
      @api_poll = PollCampaign.where(status: 1, :start_time.gte => Time.now).order_by(start_time: :asc).first
      @api_poll.is_current_poll = false if @api_poll
    end
    if @api_poll
      render :json => @api_poll.to_user_hash.merge({:results => @api_poll.results})
    else
      render :json => {error: "No upcoming"}
    end
    
  end

  def inactivate
    @api_poll.status = 0
    @api_poll.save
    @api_poll.poll_campaigns.each do |poll_campaign|
      poll_campaign.status = 0
      poll_campaign.save
    end
    render :json => @api_poll.to_hash
  end


  # GET /api/polls
  # GET /api/polls.json
  def index
    @api_polls = Poll.where(status: 1)
    # poll_options = PollOption.where(poll: @api_poll)
    
    render :json => @api_polls.map{|x| x.to_hash }
  end

  # GET /api/polls/1
  # GET /api/polls/1.json
  def show
    @api_poll = Poll.find(params[:id])
    # poll_options = PollOption.where(poll: @api_poll)
    render :json => @api_poll.to_detail_hash
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
    render :json => @api_poll.to_hash
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
