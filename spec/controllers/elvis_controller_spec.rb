require 'rails_helper'

RSpec.describe ElvisController, type: :controller do
  describe "GET #index" do
    before { get :index }
    
    it "returns a successful response with the correct template" do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response).to render_template(layout: "application")
    end
  end

  describe "Recording struct" do
    let(:recording) { ElvisController::Recording.new("Jailhouse Rock", "Elvis Presley", "gj-27Blpfos", "Jailhouse Rock") }
    
    it "generates YouTube URLs correctly" do
      expect(recording.embed_url).to eq("https://www.youtube.com/embed/gj-27Blpfos")
      expect(recording.watch_url).to eq("https://www.youtube.com/watch?v=gj-27Blpfos")
    end
  end
end 