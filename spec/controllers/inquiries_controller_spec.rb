require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
  describe "GET #index" do
    before { get :index }
    
    it "returns a successful response with the correct template" do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end
end 