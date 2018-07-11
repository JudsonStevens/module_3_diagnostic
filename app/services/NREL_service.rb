class NRELService

  def initialize
    @conn = Faraday.new(ENV["FULL_URL"])
  end

  def find_service_location_information
    @conn.get do |req|
      req.params["api_key"] = ENV["API_KEY"]
      req.params["location"] = params["q"].to_i
      req.params["radius"] = 6.0
      req.params["fuel_type"] = "ELEC,LPG"
      req.params["limit"] = 10
    end
  end

  def return_parsed_search_results
    JSON.parse(find_service_location_information.body)["fuel_stations"].map do |result|
      {
        name: result["station_name"],
        address: "#{result["street_address"]}, #{result["city"]} #{result["state"]} #{result["zip"]}",
        fuel_types: result["fuel_type_code"],
        distance: result["distance"],
        access_times: result["access_days_time"]
      }
    end
  end
end