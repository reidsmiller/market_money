class MarketsFacade
  def initialize(params)
    @name = params[:name]
    @city = params[:city]
    @state = params[:state]
  end

  def search_markets
    # validate_params
    Market.where('name ILIKE ? and city ILIKE ? and state ILIKE ?', "%#{@name}%", "%#{@city}%", "%#{@state}%")
  end
end