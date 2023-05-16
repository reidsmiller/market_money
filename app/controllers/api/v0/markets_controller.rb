class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all).serializable_hash
  end

  def show
    render json: MarketSerializer.new(Market.find(params[:id])).serializable_hash
  end
end