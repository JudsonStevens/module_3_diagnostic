require 'rails_helper'

describe 'User' do
  it 'should be able to search from the root page and see a list of results' do
    VCR.use_cassette('correct response') do
      visit('/')
      fill_in(:q, with: 80203)
      click_on("Locate")

      expect(current_path).to eq('/search')

      expect(page).to have_content('Name:', count: 10)
      expect(page).to_not have_content('Name:', count: 11)
      expect(page).to_not have_content('Name:', count: 9)

      expect(page).to have_content("Name: UDR")
      expect(page).to have_content("Address: 800 Acoma St, Denver CO 80204")
      expect(page).to have_content("Fuel Types: ELEC")
      expect(page).to have_content("Distance: 0.314")
      expect(page).to have_content("Access Times: 24 hours daily")

      expect(page).to have_content("Name: PUBLIC STATIONS")
      expect(page).to have_content("Address: 1370 Elati St, Denver CO 80204")
      expect(page).to have_content("Fuel Types: ELEC")
      expect(page).to have_content("Distance: 0.763")
      expect(page).to have_content("Access Times: 24 hours daily")
    end
  end
end
