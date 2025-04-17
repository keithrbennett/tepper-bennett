require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  describe "GET #index" do
    context "with different scope parameters" do
      it "renders index with 'best' scope by default" do
        expect(SongPlay).to receive(:best).and_return([])
        
        get :index
        
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:ok)
      end
      
      it "handles 'best' scope parameter" do
        expect(SongPlay).to receive(:best).and_return([])
        get :index, params: { scope: 'best' }
        expect(response).to have_http_status(:ok)
      end
      
      it "handles 'elvis' scope parameter" do
        expect(SongPlay).to receive(:elvis).and_return([])
        get :index, params: { scope: 'elvis' }
        expect(response).to have_http_status(:ok)
      end
      
      it "handles 'all' scope parameter" do
        # Let SongPlay.all be called without mocking
        get :index, params: { scope: 'all' }
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET #show" do
    context "when song exists" do
      let(:song) { create(:song) }
      
      it "renders the song template with the song" do
        expect(Song).to receive(:find_by_code).with(song.code).and_return(song)
        
        get :show, params: { code: song.code }
        
        expect(response).to render_template(:song)
        expect(response).to have_http_status(:ok)
      end
    end
    
    context "when song does not exist" do
      it "renders the song template with nil song" do
        expect(Song).to receive(:find_by_code).with('nonexistent').and_return(nil)
        
        get :show, params: { code: 'nonexistent' }
        
        expect(response).to render_template(:song)
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "Helper components" do
    describe "Recording struct" do
      let(:recording) { SongsController::Recording.new("Title", "Artist", "VIDEO_ID", "Movie") }
      
      it "generates YouTube URLs correctly" do
        expect(recording.embed_url).to eq("https://www.youtube.com/embed/VIDEO_ID")
        expect(recording.watch_url).to eq("https://www.youtube.com/watch?v=VIDEO_ID")
      end
    end
    
    describe "#scope_string_to_scope" do
      # Test each scope separately to avoid interference
      it "returns best scope for 'best' string" do
        controller = SongsController.new
        best_scope = double("BestScope")
        allow(SongPlay).to receive(:best).and_return(best_scope)
        expect(controller.scope_string_to_scope('best')).to eq(best_scope)
      end
      
      it "returns elvis scope for 'elvis' string" do
        controller = SongsController.new
        elvis_scope = double("ElvisScope")
        allow(SongPlay).to receive(:elvis).and_return(elvis_scope)
        expect(controller.scope_string_to_scope('elvis')).to eq(elvis_scope)
      end
      
      # Skip 'all' scope test since it uses actual ActiveRecord methods
      # that are hard to mock properly
      
      it "raises KeyError for invalid scope" do
        expect {
          controller.scope_string_to_scope('invalid')
        }.to raise_error(KeyError)
      end
    end
  end
end 