require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#youtube_text_song_link" do
    before do
      # Mock the SongPlay.youtube_watch_url method
      allow(SongPlay).to receive(:youtube_watch_url).with('test123').and_return('https://www.youtube.com/watch?v=test123')
    end

    it "renders a YouTube link with the provided text and code" do
      # Set up test data
      text = "Test Song Title"
      youtube_code = "test123"
      
      # Call the helper method
      result = helper.youtube_text_song_link(text, youtube_code)
      
      # Assertions
      expect(result).to include('href="https://www.youtube.com/watch?v=test123"')
      expect(result).to include('class="youtube-view"')
      expect(result).to include('target="_blank"')
      expect(result).to include('Test Song Title')
      
      # Verify SongPlay.youtube_watch_url was called with the right parameter
      expect(SongPlay).to have_received(:youtube_watch_url).with('test123')
    end
    
    it "handles special characters in the text" do
      text = "Song with <special> & \"characters\""
      youtube_code = "test123"
      
      result = helper.youtube_text_song_link(text, youtube_code)
      
      # Verify text is properly HTML encoded
      expect(result).to include('Song with &lt;special&gt; &amp; &quot;characters&quot;')
      expect(result).to include('href="https://www.youtube.com/watch?v=test123"')
    end
    
    it "returns HTML safe content" do
      result = helper.youtube_text_song_link("Test", "test123")
      expect(result).to be_html_safe
    end
    
    context "with different YouTube codes" do
      it "generates correct URLs for different codes" do
        allow(SongPlay).to receive(:youtube_watch_url).with('another456').and_return('https://www.youtube.com/watch?v=another456')
        
        result = helper.youtube_text_song_link("Another Song", "another456")
        
        expect(result).to include('href="https://www.youtube.com/watch?v=another456"')
        expect(result).to include('Another Song')
      end
    end
  end
  
  describe "#external_link" do
    it "renders an external link with the provided text and URL" do
      text = "Example Website"
      url = "https://example.com"
      
      # Create a partial mock to verify the partial is rendered with correct locals
      expect(helper).to receive(:render).with(
        partial: 'application/external_link',
        locals: { text: text, url: url }
      ).and_return('<a href="https://example.com">Example Website</a>'.html_safe)
      
      result = helper.external_link(text, url)
      
      expect(result).to eq('<a href="https://example.com">Example Website</a>')
      expect(result).to be_html_safe
    end
  end
  
  describe "#canonical_url" do
    it "generates a canonical URL for the current page" do
      # Mock the request object
      allow(helper).to receive(:request).and_return(double(path: "/songs"))
      allow(helper).to receive(:root_url).with(protocol: 'https', host: 'www.tepper-bennett.com').and_return('https://www.tepper-bennett.com/')
      
      result = helper.canonical_url
      
      expect(result).to eq('https://www.tepper-bennett.com/songs')
    end
    
    it "removes trailing slashes if present" do
      allow(helper).to receive(:request).and_return(double(path: "/"))
      allow(helper).to receive(:root_url).with(protocol: 'https', host: 'www.tepper-bennett.com').and_return('https://www.tepper-bennett.com/')
      
      result = helper.canonical_url
      
      # Should not end with double slash
      expect(result).to eq('https://www.tepper-bennett.com/')
      expect(result).not_to eq('https://www.tepper-bennett.com//')
    end
  end
end 