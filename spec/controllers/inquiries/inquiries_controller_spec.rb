require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do

  describe "GET #index" do
    # subject { get :index, params: default_params }
    it "responds successfully" do
      expect(response).to have_http_status(200)
      # expect(response).to render_template('/static_pages#index')
    end
  end

end
