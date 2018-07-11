class SearchController < ApplicationController
  def index
    @results = NRELService.new.return_parsed_search_results(params[:q])
  end
end
