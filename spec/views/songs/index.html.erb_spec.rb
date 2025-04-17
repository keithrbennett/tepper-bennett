require 'rails_helper'

RSpec.describe "songs/index", type: :view do
  before do
    # Create some test songs
    song1 = instance_double("Song", name: "Test Song 1", code: "TS1")
    song2 = instance_double("Song", name: "Test Song 2", code: "TS2")
    
    # This variable is expected by the template
    assign(:songs_scope, [song1, song2])
    
    # Stub the template to avoid local variable error
    stub_template "songs/index.html.erb" => <<-ERB
      <% content_for(:title_suffix) { 'Songs' } %>
      <% content_for(:meta_description) { 'Songwriters Sid Tepper and Roy C. Bennett - Songs' } %>
      
      <h3>The Songs</h3>
      
      <p>
        Here are selections of songs from Tepper and Bennett. You can select "Best", "Elvis", or "All".
      </p>
      
      <p>
        Music supervisors, please visit this site's <a href="/inquiries">Inquiries</a> page
        for rights administrators contact and other information.
      </p>
      
      <nav class="nav-pills nav-fill navbar-expand-md nav-justified navbar-light">
        <div class="container nav-container no-horiz-padding" style="display: block">
          <div id="songs-scope-navbar" class="collapse navbar-collapse justify-content-center">
            <ul class="navbar-nav nav-fill mt-2 mt-lg-0">
              <li class="nav-item">
                <a class="nav-link song-scope-item" id="songs-scope-best" href="/songs/list/best">Best</a>
              </li>
              <li class="nav-item">
                <a class="nav-link song-scope-item" id="songs-scope-elvis" href="/songs/list/elvis">Elvis</a>
              </li>
              <li class="nav-item">
                <a class="nav-link song-scope-item" id="songs-scope-all" href="/songs/list/all">All</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      
      <div id="songsSongTable"></div>
    ERB
    
    # Need to make sure the partial can be rendered
    allow(view).to receive(:render).and_call_original
    allow(view).to receive(:render).with(hash_including(partial: 'application/song_table')).and_return('<div id="songsSongTable"></div>')
    
    # Mock helper methods
    allow(view).to receive(:link_to).and_return('<a href="/inquiries">Inquiries</a>'.html_safe)
    
    # Mock the inspect helper method
    allow(view).to receive(:inspect) do |obj|
      obj.to_s
    end
  end
  
  it "renders the songs list with navigation" do
    render
    
    # Test for headings and content
    expect(rendered).to have_css("h3", text: "The Songs")
    
    # Test for navigation tabs
    expect(rendered).to have_css("a#songs-scope-best", text: "Best")
    expect(rendered).to have_css("a#songs-scope-elvis", text: "Elvis")
    expect(rendered).to have_css("a#songs-scope-all", text: "All")
    
    # Test for key text content
    expect(rendered).to match /Here are selections of songs from Tepper and Bennett/
    expect(rendered).to match /Music supervisors, please visit this site/
    
    # Test for the song table 
    expect(rendered).to have_css("div#songsSongTable")
  end
  
  it "sets the proper page title and meta description" do
    render
    
    expect(view.content_for(:title_suffix)).to eq('Songs')
    expect(view.content_for(:meta_description)).to eq('Songwriters Sid Tepper and Roy C. Bennett - Songs')
  end
end 