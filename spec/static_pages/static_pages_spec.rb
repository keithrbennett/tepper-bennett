require 'rails_helper'

# To save and open a screenshot, add `, js: true` to the `describe` call like below, and call `save_and_open_page`
RSpec.describe 'visit the home page' do
# RSpec.describe 'visit the home page', js: true do
  specify do
    visit '/'
    # save_and_open_page
    expect(page).to have_selector('.title')
    expect(page).to have_content('Tepper')
    expect(page).to have_content('Bennett')
  end
end
