class SearchController < ApplicationController
  def index
    conn = Faraday.new(ENV["FULL_URL"])
    results = conn.get do |req|
      req.params["api_key"] = ENV["API_KEY"]
      req.params["location"] = params["q"].to_i
      req.params["radius"] = 6.0
      req.params["fuel_type"] = "ELEC,LPG"
      req.params["limit"] = 10
    end
    @results = JSON.parse(results.body)["fuel_stations"].map do |result|
      {
        name: result["station_name"],
        address: "#{result["street_address"]}, #{result["state"]} #{result["zip"]}",
        fuel_types: result["fuel_type_code"],
        distance: result["distance"],
        access_times: result["access_days_time"]
      }
    end
  end
end



