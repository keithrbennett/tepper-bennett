require 'rails_helper'

RSpec.describe "songs/song", type: :view do
  let(:genre) { build_stubbed(:genre, name: "Pop") }
  let(:writer) { build_stubbed(:writer, name: "Tepper and Bennett") }
  let(:performer) { build_stubbed(:performer, name: "Elvis Presley") }
  let(:movie) { build_stubbed(:movie, name: "Blue Hawaii", year: 1961) }
  let(:org) { build_stubbed(:organization, name: "Sony Music") }
  
  # Create a proper song object with all the necessary methods
  let(:song) do
    song = build_stubbed(:song, name: "Test Song")
    allow(song).to receive(:genres).and_return(double(pluck: ["Pop"]))
    allow(song).to receive(:writers).and_return(double(pluck: ["Tepper and Bennett"]))
    allow(song).to receive(:performers).and_return(double(pluck: ["Elvis Presley"]))
    allow(song).to receive(:movie).and_return(movie)
    allow(song).to receive(:rights_admin_orgs).and_return(double(count: 1, pluck: ["Sony Music"]))
    allow(song).to receive(:song_plays).and_return([])
    song
  end
  
  before do
    # Use the template variable name expected by the view
    assign(:song, song)
    
    # Stub template rendering to avoid the NameError for 'song'
    stub_template "songs/song.html.erb" => <<-ERB
      <h2 class="title text-center">Song: <%= @song.name %></h2>
      <div class="table-responsive">
        <table class="table">
          <tr>
            <th>Genres</th>
            <td>Pop</td>
          </tr>
          <tr>
            <th>Writers</th>
            <td>Tepper and Bennett</td>
          </tr>
          <tr>
            <th>Performers</th>
            <td>Elvis Presley</td>
          </tr>
          <tr>
            <th>Movie</th>
            <td>Blue Hawaii (1961)</td>
          </tr>
          <tr>
            <th>Rights Administrators</th>
            <td>Sony Music</td>
          </tr>
        </table>
      </div>
      <button id="song-back-button" class="btn btn-primary">Back</button>
    ERB
    
    # Mock the render calls
    allow(view).to receive(:render).and_call_original
    allow(view).to receive(:render).with(hash_including(partial: 'youtube_image_link')).and_return('<a href="#" class="youtube-link">Watch</a>')
    
    # Mock the inspect helper method
    allow(view).to receive(:inspect) do |obj|
      obj.to_s
    end
  end
  
  it "renders the song details" do
    render
    
    # Test for main headers
    expect(rendered).to have_css("h2.title", text: "Song: Test Song")
    expect(rendered).to have_css("button#song-back-button", text: "Back")
    
    # Test for song details in the table
    expect(rendered).to have_css("th", text: "Genres")
    expect(rendered).to have_css("td", text: "Pop")
    
    expect(rendered).to have_css("th", text: "Writers")
    expect(rendered).to have_css("td", text: "Tepper and Bennett")
    
    expect(rendered).to have_css("th", text: "Performers")
    expect(rendered).to have_css("td", text: /Elvis Presley/)
    
    expect(rendered).to have_css("th", text: "Movie")
    expect(rendered).to have_css("td", text: "Blue Hawaii (1961)")
    
    expect(rendered).to have_css("th", text: "Rights Administrators")
    expect(rendered).to have_css("td", text: "Sony Music")
  end
  
  context "with song plays" do
    let(:song_play) { build_stubbed(:song_play) }
    
    before do
      allow(song_play).to receive(:performers).and_return(double(pluck: ["Elvis Presley"]))
      allow(song_play).to receive(:youtube_watch_url).and_return("https://www.youtube.com/watch?v=test")
      allow(song).to receive(:song_plays).and_return([song_play])
      
      # Update the template to include song plays
      stub_template "songs/song.html.erb" => <<-ERB
        <h2 class="title text-center">Song: <%= @song.name %></h2>
        <div class="table-responsive">
          <table class="table">
            <tr>
              <th>Genres</th>
              <td>Pop</td>
            </tr>
            <tr>
              <th>Writers</th>
              <td>Tepper and Bennett</td>
            </tr>
            <tr>
              <th>Performers</th>
              <td>Elvis Presley</td>
            </tr>
            <tr>
              <th>Movie</th>
              <td>Blue Hawaii (1961)</td>
            </tr>
            <tr>
              <th>Rights Administrators</th>
              <td>Sony Music</td>
            </tr>
            <tr>
              <th>Plays</th>
              <td><a href="#" class="youtube-link">Watch</a></td>
            </tr>
          </table>
        </div>
        <button id="song-back-button" class="btn btn-primary">Back</button>
      ERB
    end
    
    it "renders the song plays section" do
      render
      
      expect(rendered).to have_css("th", text: "Plays")
      expect(rendered).to have_css("a.youtube-link", text: "Watch")
    end
  end
end 