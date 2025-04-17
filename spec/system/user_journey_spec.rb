require 'rails_helper'

RSpec.describe "User Journey", type: :system do
  before do
    # Set up the database with a song and its associations
    # These will need to be created through factories or fixtures
    @genre = FactoryBot.create(:genre, name: "Pop", code: "POP")
    @performer = FactoryBot.create(:performer, name: "Elvis Presley", code: "ELVIS")
    @song = FactoryBot.create(:song, name: "Test Song", code: "TEST001")
    @song.genres << @genre
    @song.performers << @performer
    
    # Create a song play with YouTube link
    @song_play = FactoryBot.create(:song_play, 
      code: "SP001", 
      song: @song, 
      youtube_key: "dQw4w9WgXcQ") # Famous YouTube video code
    @song_play.performers << @performer
  end

  it "allows a user to navigate through the site and view song details", js: true do
    # Visit the home page
    visit root_path
    
    # Verify home page content
    expect(page).to have_content("Sid Tepper and Roy C. Bennett")
    expect(page).to have_css("img[alt*='Sid Tepper and Roy C. Bennett']")
    expect(page).to have_content("Sid and Roy were Brooklyn born and bred")
    
    # Navigate to the songs page
    find("a", text: "Songs").click
    
    # Verify songs page content
    expect(page).to have_current_path(/songs/)
    expect(page).to have_content("The Songs")
    expect(page).to have_css("a#songs-scope-best", text: "Best")
    expect(page).to have_css("a#songs-scope-elvis", text: "Elvis")
    expect(page).to have_css("a#songs-scope-all", text: "All")
    
    # Switch to "All" songs view to see our test song
    find("a#songs-scope-all").click
    
    # Wait for the songs to load
    expect(page).to have_content(@song.name)
    
    # View song details
    click_on @song.name
    
    # Verify song details page
    expect(page).to have_content("Song: #{@song.name}")
    expect(page).to have_content(@genre.name)  # Genre name
    expect(page).to have_content(@performer.name)  # Performer
    
    # Verify YouTube link
    expect(page).to have_css("a.youtube-view")
    
    # Go back to songs list
    click_button "Back"
    expect(page).to have_current_path(/songs/)
    
    # Navigate to the genres page
    click_on "Genres"
    expect(page).to have_current_path(/genres/)
    
    # Navigate to the Elvis page
    click_on "Elvis"
    expect(page).to have_current_path(/elvis/)
    
    # Navigate back to home
    click_on "Home"
    expect(page).to have_current_path(root_path)
  end
  
  it "shows the reports section with different report types" do
    visit reports_path
    
    expect(page).to have_content("Reports")
    
    # Check different report types are available
    expect(page).to have_content("Song Genres")
    expect(page).to have_content("Song Performers")
    
    # View a report
    click_on "Song Genres"
    
    # Should show our test genre
    expect(page).to have_content(@genre.name)
  end
  
  it "allows viewing resources and inquiries pages" do
    # Visit the resources page
    visit resources_path
    expect(page).to have_content("Resources")
    
    # Visit the inquiries page
    visit inquiries_path
    expect(page).to have_content("Inquiries")
    expect(page).to have_content("rights administrator")
    expect(page).to have_content("Warner Chappell Music")
    expect(page).to have_content("Universal Music Publishing Group")
  end
end 