class SearchController < ApplicationController
  def index
    require 'pry'; binding.pry
    conn = Faraday.new(ENV["FULL_URL"])
    response = conn.get do |req|
      req.params["api_key"] = ENV["API_KEY"]
      req.params["location"] = params["q"]
      req.params["radius"] = 6.0
      req.params["fuel_type"] = "ELEC,LPG"
      req.params["limit"] = 10
    end
  end
end
