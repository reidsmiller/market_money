class Api::V0::MarketsController < ApplicationController


  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(Market.find(params[:id]))
  end

  def search
    markets_or_error = MarketsFacade.new(params).search_markets
    if markets_or_error.include?('Invalid set of parameters')
      render json: ErrorSerializer.new(markets_or_error).serialize, status: 422
    else
      render json: MarketSerializer.new(markets_or_error)
    end
  end

  def nearest_atm
    atms = AtmFacade.new(Market.find(params[:id])).nearest_atms
    render json: AtmSerializer.new(atms)
  end
end