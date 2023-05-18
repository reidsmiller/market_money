class Api::V0::MarketsController < ApplicationController


  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(Market.find(params[:id]))
  end

  def search
    markets = MarketsFacade.new(params).search_markets
    if markets.include?('Invalid set of parameters')
      render json: ErrorSerializer.new(markets).serialize, status: 422
    else
      render json: MarketSerializer.new(markets)
    end
  end
end