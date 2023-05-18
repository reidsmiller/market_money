class AtmFacade
  def initialize(market)
    @market = market
  end

  def nearest_atms
    formatted_atms_data.map do |atm|
      Atm.new(atm)
    end
  end

  private

  def service
    @_service ||= AtmService.new
  end

  def atms_data
    @_atms_data ||= service.find_atms(@market.lat, @market.lon)
  end

  def formatted_atms_data
    pull_atms_data = atms_data[:results].map do |atm|
      {
        name: atm[:poi][:name],
        address: atm[:address][:streetName],
        lat: atm[:position][:lat],
        lon: atm[:position][:lon],
        distance: atm[:dist]
      }
    end
    pull_atms_data.sort_by { |atm| atm[:distance] }
  end
end