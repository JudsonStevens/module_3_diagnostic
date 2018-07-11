require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  it 'returns a successful response' do
    VCR.use_cassette('response') do
      get :index
      expect(response).to be_successful
    end
  end
end
