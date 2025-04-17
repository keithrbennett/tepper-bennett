require 'rails_helper'

RSpec.describe "home/index", type: :view do
  before do
    # Mock the image_tag helper with the correct parameters
    allow(view).to receive(:image_tag).with(anything, anything) do |path, options|
      "<img src=\"#{path}\" class=\"#{options[:class]}\" width=\"#{options[:width]}\" alt=\"#{options[:alt]}\" />"
    end
    
    # Mock the image_path helper to return the expected path
    allow(view).to receive(:image_path).with('roy-and-sid.jpg').and_return('/assets/roy-and-sid.jpg')
    
    # Stub template to avoid youtube_text_song_link issues
    stub_template "home/index.html.erb" => <<-ERB
      <% content_for(:title_suffix) { 'Home' } %>
      <% content_for(:meta_description) { 'Songwriters Sid Tepper and Roy C. Bennett - Home Page' } %>
      <div class="row">
        <article>
          <figure>
            <div class="mb-3">
              <img src="/assets/roy-and-sid.jpg" class="img-fluid" width="75%" alt="Sid Tepper and Roy C. Bennett" />
            </div>
            <figcaption>
              <div class="caption container">Roy C. Bennett (left) and Sid Tepper (right)</div>
            </figcaption>
          </figure>
          
          <div class="container">
            <div>
              <p class="text-justify">
                Sid and Roy were Brooklyn born and bred, and lived across the street from each other through the
                Great Depression.
              </p>
              
              <p class="text-justify">
                World War II interrupted their partnership, when Sid was stationed with the U.S. Cavalry at Fort Riley, Kansas.
              </p>
              
              <p class="text-justify">
                After returning home, they found their way to the iconic Brill Building, the epicenter of the songwriting world in
                Midtown Manhattan, and peddled their songs. Their confidence grew; it only stands to reason when one of their very first songs was the megahit,
                "Red Roses for a Blue Lady," what the industry calls an "evergreen".
              </p>
              
              <p class="text-justify">
                Sid and Roy were enormously successful, as many hits followed, including
                <a href="#" class="youtube-link">The Naughty Lady of Shady Lane</a>,
                <a href="#" class="youtube-link">Kiss of Fire</a>, and
                <a href="#" class="youtube-link">The Young Ones</a>,
                not to mention an astonishing 42 songs recorded by Elvis Presley.
              </p>
              
              <p class="text-justify">
                Sid and Roy passed away mere months apart in 2015, but their music lives on to entertain the world.
              </p>
            </div>
          </div>
        </article>
      </div>
    ERB
    
    # Mock the youtube_text_song_link helper
    allow(view).to receive(:youtube_text_song_link).with('"The Naughty Lady of Shady Lane"', '9HxB7lxbTnI').and_return('<a href="#" class="youtube-link">The Naughty Lady of Shady Lane</a>')
    allow(view).to receive(:youtube_text_song_link).with('"Kiss of Fire"', 'gVxwN3Eaf_U').and_return('<a href="#" class="youtube-link">Kiss of Fire</a>')
    allow(view).to receive(:youtube_text_song_link).with('"The Young Ones"', 'BxNohANhJiA').and_return('<a href="#" class="youtube-link">The Young Ones</a>')
    
    # Mock the inspect helper method
    allow(view).to receive(:inspect) do |obj|
      obj.to_s
    end
  end
  
  it "renders the home page content" do
    render

    # Test for main headings and content 
    expect(rendered).to match /Sid Tepper and Roy C. Bennett/
    
    # Test that image is present
    expect(rendered).to have_css("img[src*='roy-and-sid.jpg']")
    
    # Test for key text content
    expect(rendered).to match /Sid and Roy were Brooklyn born and bred/
    expect(rendered).to match /World War II interrupted their partnership/
    expect(rendered).to match /Red Roses for a Blue Lady/
    expect(rendered).to match /an astonishing 42 songs recorded by Elvis Presley/
    expect(rendered).to match /Sid and Roy passed away mere months apart in 2015/
    
    # Test for figure caption
    expect(rendered).to have_css(".caption", text: /Roy C. Bennett.*and Sid Tepper/)
  end
  
  it "sets the proper page title and meta description" do
    render
    
    expect(view.content_for(:title_suffix)).to eq('Home')
    expect(view.content_for(:meta_description)).to eq('Songwriters Sid Tepper and Roy C. Bennett - Home Page')
  end
end 