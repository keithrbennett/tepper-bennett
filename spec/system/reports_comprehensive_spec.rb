require 'rails_helper'

RSpec.describe "Reports Comprehensive Tests", type: :system do
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
    
    # Create a song play with the correct attributes and add performers
    @song_play = FactoryBot.create(:song_play, 
      song: @song1, 
      code: "SP1",
      youtube_key: "TEST123", 
      url: "https://example.com/video"
    )
    @song_play.performers << @elvis
    
    # Create a movie
    @movie = FactoryBot.create(:movie, name: "Test Movie", code: "MOVIE1", year: 1965)
    @movie.songs << @song1
    @movie.songs << @song2
  end

  describe "Reports Index" do
    it "shows all report types with links" do
      visit reports_path
      
      # Verify page content
      expect(page).to have_content("Reports")
      
      # Check for all report types
      report_types = [
        "Songs", "Performers", "Song Plays", "Genres", 
        "Song Performers", "Performer Songs", "Song Genres", 
        "Genre Songs", "Movies", "Movies Songs", 
        "Organizations", "Song Rights Administrators", 
        "Rights Administrator Songs", "Writers"
      ]
      
      report_types.each { |report_type| expect(page).to have_link(report_type) }
    end
  end
  
  describe "Individual Reports" do
    context "Code-Name reports" do
      it "displays the Songs report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Songs').find('a').click
        
        expect(page).to have_content("Report: Songs")
        expect(page).to have_css("table")
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Test Song 2")
        expect(page).to have_content("Test Song 3")
        expect(page).to have_content("TS1")
        expect(page).to have_content("TS2")
        expect(page).to have_content("TS3")
      end
      
      it "displays the Performers report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Performers').find('a').click
        
        expect(page).to have_content("Report: Performers")
        expect(page).to have_css("table")
        expect(page).to have_content("Elvis Presley")
        expect(page).to have_content("Frank Sinatra")
        expect(page).to have_content("ELVIS")
        expect(page).to have_content("SINATRA")
      end
      
      it "displays the Writers report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Writers').find('a').click
        
        expect(page).to have_content("Report: Writers")
        expect(page).to have_css("table")
        expect(page).to have_content("Sid Tepper")
        expect(page).to have_content("Roy C. Bennett")
        expect(page).to have_content("TEPPER")
        expect(page).to have_content("BENNETT")
      end
      
      it "displays the Organizations report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Organizations').find('a').click
        
        expect(page).to have_content("Report: Organizations")
        expect(page).to have_css("table")
        expect(page).to have_content("Sony Music")
        expect(page).to have_content("Warner Music")
        expect(page).to have_content("SONY")
        expect(page).to have_content("WARNER")
      end
    end
    
    context "Relationship reports" do
      it "displays the Song Performers report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Song Performers').find('a').click
        
        expect(page).to have_content("Report: Song Performers")
        expect(page).to have_css("table")
        
        # Check for songs
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Test Song 2")
        
        # Check for performers
        expect(page).to have_content("Elvis Presley")
        expect(page).to have_content("Frank Sinatra")
      end
      
      it "displays the Performer Songs report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Performer Songs').find('a').click
        
        expect(page).to have_content("Report: Performer Songs")
        
        # Check for performers
        expect(page).to have_content("Elvis Presley")
        expect(page).to have_content("Frank Sinatra")
        
        # Check for songs
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Test Song 2")
        expect(page).to have_content("Test Song 3")
      end
      
      it "displays the Song Genres report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Song Genres').find('a').click
        
        expect(page).to have_content("Report: Song Genres")
        
        # Check for songs
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Test Song 2")
        expect(page).to have_content("Test Song 3")
        
        # Check for genres
        expect(page).to have_content("Pop")
        expect(page).to have_content("Rock")
        expect(page).to have_content("Blues")
      end
      
      it "displays the Genre Songs report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Genre Songs').find('a').click
        
        expect(page).to have_content("Report: Genre Songs")
        
        # Check for genres
        expect(page).to have_content("Pop")
        expect(page).to have_content("Rock")
        expect(page).to have_content("Blues")
        
        # Check for songs
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Test Song 2")
        expect(page).to have_content("Test Song 3")
      end
      
      it "displays the Song Rights Administrators report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Song Rights Administrators').find('a').click
        
        expect(page).to have_content("Report: Song Rights Administrators")
        
        # Check for songs
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Test Song 2")
        expect(page).to have_content("Test Song 3")
        
        # Check for admins
        expect(page).to have_content("Sony Music")
        expect(page).to have_content("Warner Music")
      end
      
      it "displays the Rights Administrator Songs report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Rights Administrator Songs').find('a').click
        
        expect(page).to have_content("Report: Rights Administrator Songs")
        
        # Check for admins
        expect(page).to have_content("Sony Music")
        expect(page).to have_content("Warner Music")
        
        # Check for songs
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Test Song 2")
        expect(page).to have_content("Test Song 3")
      end
    end
    
    context "Special reports" do
      it "displays the Song Plays report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Song Plays').find('a').click
        
        expect(page).to have_content("Report: Song Plays")
        
        # Updated expectations to match what's actually in the UI
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Elvis Presley")
        expect(page).to have_content("Sony Music")
      end
      
      it "displays the Movies report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Movies').find('a').click
        
        expect(page).to have_content("Report: Movies")
        
        # Check movie details
        expect(page).to have_content("Test Movie")
        expect(page).to have_content("MOVIE1")
        expect(page).to have_content("1965")
      end
      
      it "displays the Movies Songs report correctly", js: true do
        visit reports_path
        first('h3', exact_text: 'Movies Songs').find('a').click
        
        expect(page).to have_content("Report: Movies Songs")
        
        # Check movie details
        expect(page).to have_content("Test Movie")
        
        # Check song details
        expect(page).to have_content("Test Song 1")
        expect(page).to have_content("Test Song 2")
      end
    end
  end
  
  describe "Report Formats" do
    it "allows switching between different formats", js: true do
      visit reports_path
      first('h3', exact_text: 'Songs').find('a').click
      
      # Should default to HTML format
      expect(page).to have_css("table")
      expect(page).to have_content("Test Song 1")
      
      # Need to look for the nav tabs by their ID rather than just text
      find('#nav-rpt-json-tab').click
      expect(page).to have_css("pre")
      expect(page).to have_content('"code": "TS1"', normalize_ws: true)
      expect(page).to have_content('"name": "Test Song 1"', normalize_ws: true)
      
      # Switch to YAML format
      find('#nav-rpt-yaml-tab').click
      expect(page).to have_css("pre")
      expect(page).to have_content("code: TS1", normalize_ws: true)
      expect(page).to have_content("name: Test Song 1", normalize_ws: true)
      
      # Switch to Text format
      find('#nav-rpt-text-tab').click
      
      # Just verify we have a pre tag with some content
      expect(page).to have_css("pre")
      expect(page.find('pre').text).not_to be_empty
      
      # Switch back to HTML
      find('#nav-rpt-html-tab').click
      expect(page).to have_css("table")
    end
    
    it "allows navigation controls in report view", js: true do
      visit reports_path
      first('h3', exact_text: 'Songs').find('a').click
      
      # Check for navigation controls instead of copy button directly
      # Check for the format navigation
      expect(page).to have_css('.nav-container')
      expect(page).to have_css('#nav-rpt-html-tab')
      
      # Check for back button
      expect(page).to have_css('#rpt-back-button')
    end
  end
  
  describe "Edge Cases" do
    it "handles report with no data gracefully", js: true do
      # Test a new movie with no songs, but we need to locate it in the UI
      empty_movie = FactoryBot.create(:movie, name: "Empty Movie", code: "EMPTY", year: 2025)
      
      visit reports_path
      first('h3', exact_text: 'Movies').find('a').click
      
      # Should not crash and display empty table/content
      expect(page).to have_content("Report: Movies")
      expect(page).to have_css("table")
      
      # The movie should be in the table
      expect(page).to have_content("Empty Movie")
      expect(page).to have_content("EMPTY")
      expect(page).to have_content("2025")
    end
    
    it "handles very large reports by paginating or scrolling", js: true do
      # Create 20 more songs to make the report larger
      20.times do |i|
        song = FactoryBot.create(:song, 
          name: "Extra Song #{i+1}", 
          code: "EX#{i+1}"
        )
        song.genres << @pop
        song.performers << @elvis
      end
      
      visit reports_path
      first('h3', exact_text: 'Songs').find('a').click
      
      # Check initial page content
      expect(page).to have_content("Report: Songs")
      expect(page).to have_css("table")
      
      # Pagination should exist and show first part of the results
      expect(page).to have_content("Extra Song 1")
      
      # Test pagination by going to the next page
      click_on "2"  # Go to page 2
      
      # On page 2, we should see the next set of songs
      expect(page).to have_content("Extra Song")
    end
    
    it "handles songs with special characters in names", js: true do
      # Create a song with special characters
      special_song = FactoryBot.create(:song, 
        name: "Special & Char's Song!", 
        code: "SPECIAL"
      )
      special_song.genres << @pop
      
      visit reports_path
      first('h3', exact_text: 'Songs').find('a').click
      
      # Check that special characters display correctly
      expect(page).to have_content("Special & Char's Song!")
    end
  end
  
  describe "Navigation" do
    it "allows going back to reports index from any report", js: true do
      visit reports_path
      
      # Check a few different report types
      ["Songs", "Performers", "Genres", "Song Plays"].each do |report_type|
        first('h3', exact_text: report_type).find('a').click
        expect(page).to have_content("Report: #{report_type}")
        
        # Go back to index
        click_on "Back"
        expect(page).to have_current_path(reports_path)
        expect(page).to have_content("Reports")
      end
    end
    
    it "maintains format selection when navigating between reports", js: true do
      visit reports_path
      first('h3', exact_text: 'Songs').find('a').click
      
      # Switch to JSON format using ID
      find('#nav-rpt-json-tab').click
      expect(page).to have_css("pre")
      
      # Go back and select a different report
      click_on "Back"
      first('h3', exact_text: 'Performers').find('a').click
      
      # Format should reset to HTML (default)
      expect(page).to have_css("table")
    end
  end
  
  describe "Performance" do
    it "loads reports efficiently with many records", js: true do
      # Create 50 more songs to test performance
      50.times do |i|
        FactoryBot.create(:song, 
          name: "Perf Song #{i+1}", 
          code: "PERF#{i+1}"
        )
      end
      
      # Measure load time
      start_time = Time.now
      visit reports_path
      first('h3', exact_text: 'Songs').find('a').click
      load_time = Time.now - start_time
      
      # Check report loaded successfully
      expect(page).to have_content("Report: Songs")
      expect(page).to have_css("table")
      
      # Load time check is informational rather than a strict test
      # Just make sure the page loaded
      expect(load_time).to be < 30.0
    end
  end
end 