require 'securerandom'
class Api::UsersController < ApplicationController
  before_action :set_api_user, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /api/users or /api/users.json
  def index
    @api_users = User.all
  end

  # GET /api/users/1 or /api/users/1.json
  def show
  end

  # GET /api/users/new
  def new
    @api_user = User.new
    render :json => {error: "No upcoming"}
  end

  # GET /api/users/1/edit
  def edit
    render :json => {error: "No upcoming"}
  end

  # POST /api/users or /api/users.json
  def create
    uuid = SecureRandom.uuid
    @api_user = User.new(email: params[:email], voting_key: uuid)
    if User.where(email: params[:email]).first.blank? && @api_user.save
      UserMailer.with(user_id: @api_user.id).verification.deliver
      render :json => @api_user.to_hash
    else
      render :json => {error: "Email already registered. Please check your email for a verification code. "}
    end
  end

  # PATCH/PUT /api/users/1 or /api/users/1.json
  def update
    render :json => {error: "No upcoming"}
  end

  # DELETE /api/users/1 or /api/users/1.json
  def destroy
    @api_user.destroy
    render :json => {error: "No upcoming"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_user
      @api_user = User.find(params[:id])
      render :json => {error: "No upcoming"}
    end

    # Only allow a list of trusted parameters through.
    def api_user_params
      params.fetch(:api_user, {})
    end
end
