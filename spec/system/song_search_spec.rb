require 'rails_helper'

RSpec.describe "Song Search", type: :system do
  before do
    # Create a set of songs with different genres and performers
    @pop_genre = FactoryBot.create(:genre, name: "Pop", code: "POP")
    @rock_genre = FactoryBot.create(:genre, name: "Rock", code: "ROCK")
    
    @elvis = FactoryBot.create(:performer, name: "Elvis Presley", code: "ELVIS")
    @other_performer = FactoryBot.create(:performer, name: "Another Singer", code: "OTHER")
    
    # Create Elvis songs
    @elvis_song1 = FactoryBot.create(:song, name: "Elvis Song 1", code: "ELVIS001")
    @elvis_song1.genres << @rock_genre
    @elvis_song1.performers << @elvis
    
    @elvis_song2 = FactoryBot.create(:song, name: "Elvis Song 2", code: "ELVIS002")
    @elvis_song2.genres << @pop_genre
    @elvis_song2.performers << @elvis
    
    # Create non-Elvis songs
    @other_song = FactoryBot.create(:song, name: "Non-Elvis Song", code: "OTHER001")
    @other_song.genres << @pop_genre
    @other_song.performers << @other_performer
    
    # Create song plays
    @song_play1 = FactoryBot.create(:song_play, code: "SP001", song: @elvis_song1, youtube_key: "abcd1234")
    @song_play1.performers << @elvis
    
    @song_play2 = FactoryBot.create(:song_play, code: "SP002", song: @elvis_song2, youtube_key: "efgh5678")
    @song_play2.performers << @elvis
  end

  # Single test focused on verifying we can navigate between tabs
  it "navigates through the song tabs", js: true do
    visit songs_path
    
    # Verify we're on the Songs page
    expect(page).to have_content("The Songs")
    
    # Verify the tab navigation is present
    expect(page).to have_css("a#songs-scope-best")
    expect(page).to have_css("a#songs-scope-elvis")
    expect(page).to have_css("a#songs-scope-all")
    
    # Click on each tab to verify it works
    find("a#songs-scope-elvis").click
    expect(page).to have_css(".nav-link.active", text: /elvis/i)
    
    find("a#songs-scope-all").click
    expect(page).to have_css(".nav-link.active", text: /all/i)
    
    find("a#songs-scope-best").click
    expect(page).to have_css(".nav-link.active", text: /best/i)
  end
  
  # Test to verify song details page can be accessed
  it "can navigate to individual song details", js: true do
    # Create a "best" song play that will show up in the default view
    # Use one of the actual best codes from the model
    best_song = FactoryBot.create(:song, name: "Best Test Song", code: "BEST001")
    best_song.performers << @elvis
    best_play = FactoryBot.create(:song_play, code: "red-roses.andy-wms", song: best_song, youtube_key: "test123")
    best_play.performers << @elvis
    
    visit songs_path
    
    # The Best tab should be active by default
    expect(page).to have_css(".nav-link.active", text: /best/i)
    
    # Wait for AJAX content to load and become visible
    sleep(1)
    
    # Verify our song is in the results
    expect(page).to have_content("Best Test Song")
    
    # Let's try clicking on the row or title directly
    # Different approaches since exact UI might vary
    begin
      # Try finding a link with the song title
      click_on "Best Test Song"
    rescue
      begin
        # Try finding the text in a table cell
        find("td", text: "Best Test Song").click
      rescue
        # Try clicking the first row in the song table
        find("table#dataTable tbody tr:first-child").click
      end
    end
    
    # After clicking, should be on the song details page
    # Wait a moment for the page to load
    sleep(1)
    
    # Now we should be on a song details page
    expect(page).to have_content("Song:")
    
    # Go back to the songs list
    expect(page).to have_button("Back")
    click_button "Back"
    
    # We should be back on the songs page
    expect(page).to have_content("The Songs")
  end
end 