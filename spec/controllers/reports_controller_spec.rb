require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe "GET #index" do
    before { get :index }
    
    it "returns a successful response with the correct template" do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:report_type) { 'songs' }

    context "with a valid report type" do
      # Create test doubles for the report and metadata
      let(:mock_report) { double("Report", populate: nil) }
      let(:mock_metadata) { double("ReportMetadata", report: mock_report, locals: {}) }

      before do
        # Define test class if needed
        unless defined?(ReportMetadata)
          class ReportMetadata < Struct.new(:rpt_type, :title, :report)
            def locals; {}; end
          end
        end
        
        # Mock controller behavior
        allow(controller).to receive(:reports_metadata).and_return(
          { report_type => mock_metadata }
        )
        
        get :show, params: { rpt_type: report_type }
      end

      it "returns a successful response and calls populate on the report" do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template("reports/report")
        expect(mock_report).to have_received(:populate)
      end
    end

    context "with an invalid report type" do
      before do
        allow(controller).to receive(:reports_metadata).and_return({})
      end
      
      it "raises an error when report type doesn't exist" do
        expect {
          get :show, params: { rpt_type: 'invalid_report_type' }
        }.to raise_error(NoMethodError)
      end
    end
  end

  describe "#reports_metadata" do
    it "returns and memoizes a hash of report metadata" do
      # First call should create the hash
      result = controller.reports_metadata
      expect(result).to be_a(Hash)
      expect(result).not_to be_empty
      
      # Second call should return the same object
      expect(controller.instance_variable_get(:@reports_metadata)).to eq(result)
      
      # Should contain key report types
      expect(result.keys).to include('songs', 'performers', 'genres')
    end
  end
end 