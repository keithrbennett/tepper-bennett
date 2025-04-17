require 'rails_helper'

RSpec.describe "Reports", type: :system do
  before do
    # Create test data for reports
    
    # Genres
    @pop = FactoryBot.create(:genre, name: "Pop", code: "POP")
    @rock = FactoryBot.create(:genre, name: "Rock", code: "ROCK")
    @blues = FactoryBot.create(:genre, name: "Blues", code: "BLUES")
    
    # Performers
    @elvis = FactoryBot.create(:performer, name: "Elvis Presley", code: "ELVIS")
    @sinatra = FactoryBot.create(:performer, name: "Frank Sinatra", code: "SINATRA")
    
    # Writers
    @tepper = FactoryBot.create(:writer, name: "Sid Tepper", code: "TEPPER")
    @bennett = FactoryBot.create(:writer, name: "Roy C. Bennett", code: "BENNETT")
    
    # Organizations (Rights Administrators)
    @sony = FactoryBot.create(:organization, name: "Sony Music", code: "SONY")
    @warner = FactoryBot.create(:organization, name: "Warner Music", code: "WARNER")
    
    # Songs
    @song1 = FactoryBot.create(:song, name: "Test Song 1", code: "TS1")
    @song1.genres << @pop
    @song1.performers << @elvis
    @song1.writers << @tepper
    @song1.writers << @bennett
    @song1.rights_admin_orgs << @sony
    
    @song2 = FactoryBot.create(:song, name: "Test Song 2", code: "TS2")
    @song2.genres << @rock
    @song2.performers << @sinatra
    @song2.writers << @tepper
    @song2.writers << @bennett
    @song2.rights_admin_orgs << @warner
    
    @song3 = FactoryBot.create(:song, name: "Test Song 3", code: "TS3")
    @song3.genres << @blues
    @song3.genres << @rock
    @song3.performers << @elvis
    @song3.writers << @tepper
    @song3.writers << @bennett
    @song3.rights_admin_orgs << @sony
  end

  it "shows the reports index page with all report types" do
    visit reports_path
    
    expect(page).to have_content("Reports")
    
    # Check all report types are listed
    expect(page).to have_content("Song Genres")
    expect(page).to have_content("Song Performers")
    expect(page).to have_content("Song Rights Administrators")
    expect(page).to have_content("Song Plays")
    
    # Each report type should have a link
    expect(page).to have_link("Song Genres")
    expect(page).to have_link("Song Performers")
    expect(page).to have_link("Song Rights Administrators")
  end
  
  it "displays the Song Genres report", js: true do
    visit reports_path
    
    # Navigate to Song Genres report
    click_on "Song Genres"
    
    # Check report content
    expect(page).to have_content("Report: Song Genres")
    
    # Our test genres should be listed
    expect(page).to have_content(@pop.name)
    expect(page).to have_content(@rock.name)
    expect(page).to have_content(@blues.name)
    
    # The report should show songs in a table
    expect(page).to have_css("table")
    
    # We expect our test songs to be in the report
    expect(page).to have_content("Test Song 1")
    expect(page).to have_content("Test Song 2")
    expect(page).to have_content("Test Song 3")
  end
  
  it "displays the Song Performers report", js: true do
    visit reports_path
    
    # Navigate to Song Performers report
    click_on "Song Performers"
    
    # Check report content
    expect(page).to have_content("Report: Song Performers")
    
    # Our test performers should be listed
    expect(page).to have_content(@elvis.name)
    expect(page).to have_content(@sinatra.name)
    
    # We expect our test songs to be in the report
    expect(page).to have_content("Test Song 1")
    expect(page).to have_content("Test Song 2")
    expect(page).to have_content("Test Song 3")
    
    # Verify the associations
    expect(page).to have_content("Elvis Presley")
    expect(page).to have_content("Frank Sinatra")
  end
  
  it "allows navigation back to reports index", js: true do
    visit reports_path
    
    # Navigate to a report
    click_on "Song Genres"
    
    # Navigate back to reports index
    click_on "Back"
    
    # Should be back on the reports index page
    expect(page).to have_current_path(reports_path)
    expect(page).to have_content("Reports")
  end
end 