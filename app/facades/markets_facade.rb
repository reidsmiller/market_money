class MarketsFacade
  def initialize(params)
    @name = params[:name]
    @city = params[:city]
    @state = params[:state]
  end

  def search_markets
    if validate_params
      Market.where('name ILIKE ? and city ILIKE ? and state ILIKE ?', "%#{@name}%", "%#{@city}%", "%#{@state}%")
    else
      'Invalid set of parameters. Please provide a valid set of parameters to peform a search with this endpoint.'
    end
  end

  def validate_params
    just_city_and_name? || just_city? ? false : true
  end

  def just_city_and_name?
    @city.present? && @name.present? && @state.blank?
  end

  def just_city?
    @city.present? && @name.blank? && @state.blank?
  end
end