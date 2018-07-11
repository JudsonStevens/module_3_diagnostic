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
    require 'pry'; binding.pry
    JSON.parse(results.body.to_json)["fuel_stations"].each do |result|
      require 'pry'; binding.pry
      @results << {name: result["station_name"] }
    end
  end
end



