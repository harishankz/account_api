class Api::V1::AccountsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: "Account"
  before_action :set_account, only: [:show, :update, :destroy]

  # GET /accounts
  def index
    @accounts = Account.all
    authorize! :read, @accounts
    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    @account.customer_id = params[:customer]

    if params[:customer].blank?
      customer_api = CustomerApi.new(current_user.token)
      response = customer_api.create(params[:customer_params])
      @account.customer_id = response[:body][:user_id] if [200, 201].include? response[:status]
    end

    if @account.save
      render json: @account, status: :created, location: api_v1_account_url(@account)
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    customized_account_params = account_params
    customized_account_params[:customer_id] = params[:customer]
    if @account.update(customized_account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:account_type, :open_date, :branch, :minor_indicator, :customer_name, :customer_id)
    end
end
