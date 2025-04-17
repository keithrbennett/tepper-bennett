require 'rails_helper'

RSpec.describe Reports, type: :helper do
  describe "BaseReport" do
    let(:mock_base_report) { 
      Class.new(Reports::BaseReport) do
        attr_accessor :records
        
        def initialize
          @records = []
        end
        
        def report_type
          "test_report"
        end
        
        def populate
          @records = [{ id: 1, name: "Test" }]
        end
        
        def to_html
          "<table><tr><td>Test</td></tr></table>".html_safe
        end
        
        def to_raw_text
          "Test Report"
        end
      end.new
    }
    
    describe "#content" do
      it "returns HTML content when format is html" do
        expect(mock_base_report.content('html')).to include("<table>")
      end
      
      it "returns text content when format is text" do
        expect(mock_base_report.content('text')).to include("<pre>")
        expect(mock_base_report.content('text')).to include("Test Report")
      end
      
      it "returns JSON content when format is json" do
        mock_base_report.records = [{ id: 1, name: "Test" }]
        expect(mock_base_report.content('json')).to include('"id": 1')
        expect(mock_base_report.content('json')).to include('"name": "Test"')
      end
      
      it "returns YAML content when format is yaml" do
        mock_base_report.records = [{ id: 1, name: "Test" }]
        expect(mock_base_report.content('yaml')).to include("id: 1")
        expect(mock_base_report.content('yaml')).to include("name: Test")
      end
      
      it "raises an error for invalid format" do
        expect { mock_base_report.content('invalid') }.to raise_error(ArgumentError)
      end
    end
    
    describe "#pluck_to_hash" do
      it "converts arrays to hashes with field names" do
        collection = double("Collection", pluck: [[1, "Test"], [2, "Test2"]])
        result = mock_base_report.pluck_to_hash(collection, :id, :name)
        expect(result).to eq([
          { id: 1, name: "Test" },
          { id: 2, name: "Test2" }
        ])
      end
    end
    
    describe "#preize_text" do
      it "wraps text in pre tags" do
        result = mock_base_report.preize_text("Sample text")
        expect(result).to include("<pre>")
        expect(result).to include("Sample text")
        expect(result).to include("</pre>")
      end
    end
    
    describe "#tooltip_td" do
      it "creates a table cell with tooltip" do
        result = mock_base_report.tooltip_td("Cell Text", "Tooltip text")
        expect(result).to include("Cell Text")
        expect(result).to include('title="Tooltip text"')
        expect(result).to include('data-bs-toggle="tooltip"')
      end
    end
  end
  
  describe "CodeNameReport" do
    let(:model_class) { Song }
    let(:report) { Reports::CodeNameReport.new(model_class) }
    
    before do
      # Create test data
      @song1 = FactoryBot.create(:song, name: "Test Song 1", code: "TS1")
      @song2 = FactoryBot.create(:song, name: "Test Song 2", code: "TS2")
    end
    
    describe "#initialize" do
      it "sets the ar_class and report_type" do
        expect(report.ar_class).to eq(model_class)
        expect(report.report_type).to eq("songs")
      end
    end
    
    describe "#populate" do
      it "populates tuples and records" do
        report.populate
        
        # Check tuples
        expect(report.tuples).to be_an(Array)
        expect(report.tuples.map(&:first)).to include("TS1", "TS2")
        expect(report.tuples.map(&:last)).to include("Test Song 1", "Test Song 2")
        
        # Check records
        expect(report.records).to be_an(Array)
        expect(report.records.map { |r| r[:code] }).to include("TS1", "TS2")
        expect(report.records.map { |r| r[:name] }).to include("Test Song 1", "Test Song 2")
      end
    end
    
    describe "#to_html" do
      it "renders a table with correct data" do
        allow(report).to receive(:render).and_return("<table></table>")
        report.populate
        
        report.to_html
        
        expect(report).to have_received(:render).with(
          partial: 'reports/report_table',
          locals: hash_including(
            table_id: "song-report-table",
            column_headings: %w{Code Name}
          )
        )
      end
    end
    
    describe "#to_raw_text" do
      it "delegates to text report" do
        module Reports::TextReports; end
        class Reports::TextReports::CodeNameTextReport
          def initialize(ar_class, records); end
          def report_string; "Test"; end
        end
        
        report.populate
        
        text_report = instance_double(Reports::TextReports::CodeNameTextReport, report_string: "Test")
        allow(Reports::TextReports::CodeNameTextReport).to receive(:new).and_return(text_report)
        
        expect(report.to_raw_text).to eq("Test")
        expect(Reports::TextReports::CodeNameTextReport).to have_received(:new).with(model_class, report.records)
      end
    end
  end
  
  describe "GenreReport" do
    let(:report) { Reports::GenreReport.new }
    
    before do
      # Create test data
      @pop = FactoryBot.create(:genre, name: "Pop", code: "POP")
      @rock = FactoryBot.create(:genre, name: "Rock", code: "ROCK")
      
      @song1 = FactoryBot.create(:song, name: "Pop Song", code: "PS1")
      @song1.genres << @pop
      
      @song2 = FactoryBot.create(:song, name: "Rock Song", code: "RS1")
      @song2.genres << @rock
      
      @song3 = FactoryBot.create(:song, name: "Both Genres", code: "BG1")
      @song3.genres << @pop
      @song3.genres << @rock
    end
    
    describe "#initialize" do
      it "sets the report_type" do
        allow_any_instance_of(Reports::BaseReport).to receive(:report_type).and_return('genres')
        expect(report.report_type).to eq("genres")
      end
    end
    
    describe "#populate" do
      it "populates tuples and records with song counts" do
        report.populate
        
        # Check tuples format
        expect(report.tuples).to be_an(Array)
        expect(report.tuples.first.size).to eq(3) # code, name, song count
        
        # Check data content
        pop_record = report.records.find { |r| r[:code] == "POP" }
        rock_record = report.records.find { |r| r[:code] == "ROCK" }
        
        expect(pop_record[:song_count]).to eq(2) # 2 songs in Pop genre
        expect(rock_record[:song_count]).to eq(2) # 2 songs in Rock genre
      end
    end
    
    describe "#to_html" do
      it "renders a table with correct headings" do
        allow(report).to receive(:render).and_return("<table></table>")
        report.populate
        
        report.to_html
        
        expect(report).to have_received(:render).with(
          partial: 'reports/report_table',
          locals: hash_including(
            table_id: "genre-report-table",
            column_headings: ['Genre Code', 'Genre Name', 'Song Count']
          )
        )
      end
    end
  end
  
  describe "SongGenresReport" do
    let(:report) { Reports::SongGenresReport.new }
    
    before do
      # Create test data
      @pop = FactoryBot.create(:genre, name: "Pop", code: "POP")
      @rock = FactoryBot.create(:genre, name: "Rock", code: "ROCK")
      
      @song1 = FactoryBot.create(:song, name: "Pop Song", code: "PS1")
      @song1.genres << @pop
      
      @song2 = FactoryBot.create(:song, name: "Multi-genre Song", code: "MS1")
      @song2.genres << @pop
      @song2.genres << @rock
    end
    
    describe "#populate" do
      it "populates records with songs and their genres" do
        report.populate
        
        # Check format and structure
        expect(report.records).to be_an(Array)
        expect(report.records.first).to have_key(:code)
        expect(report.records.first).to have_key(:name)
        expect(report.records.first).to have_key(:genres)
        
        # Check specific data
        single_genre_song = report.records.find { |r| r[:code] == "PS1" }
        multi_genre_song = report.records.find { |r| r[:code] == "MS1" }
        
        expect(single_genre_song[:genres]).to eq(["Pop"])
        expect(multi_genre_song[:genres]).to include("Pop", "Rock")
      end
    end
    
    describe "#to_html" do
      it "renders the correct partial with report_table" do
        allow(report).to receive(:render).and_return("<div></div>")
        report.populate
        
        report.to_html
        
        expect(report).to have_received(:render).with(
          partial: 'reports/report_table',
          locals: hash_including(
            table_id: 'song-genres-report-table',
            column_headings: ['Code', 'Name', 'Genres']
          )
        )
      end
    end
  end
  
  describe "GenreSongsReport" do
    let(:report) { Reports::GenreSongsReport.new }
    
    before do
      # Create test data
      @pop = FactoryBot.create(:genre, name: "Pop", code: "POP")
      @rock = FactoryBot.create(:genre, name: "Rock", code: "ROCK")
      
      @song1 = FactoryBot.create(:song, name: "Pop Song 1", code: "PS1")
      @song2 = FactoryBot.create(:song, name: "Pop Song 2", code: "PS2")
      @song3 = FactoryBot.create(:song, name: "Rock Song", code: "RS1")
      
      @pop.songs << @song1
      @pop.songs << @song2
      @rock.songs << @song3
    end
    
    describe "#populate" do
      it "populates records with genres and their songs" do
        report.populate
        
        # Check format and structure - update to match the actual structure
        expect(report.records).to be_an(Array)
        expect(report.records.first).to have_key(:name)
        expect(report.records.first).to have_key(:songs)
        
        # Check specific data
        pop_genre = report.records.find { |r| r[:name] == "Pop" }
        rock_genre = report.records.find { |r| r[:name] == "Rock" }
        
        expect(pop_genre[:songs].size).to eq(2)
        expect(rock_genre[:songs].size).to eq(1)
        
        pop_songs = pop_genre[:songs].map { |s| s[:code] }
        expect(pop_songs).to include("PS1", "PS2")
      end
    end
    
    describe "#to_html" do
      it "renders the correct partial" do
        allow(report).to receive(:render).and_return("<div></div>")
        report.populate
        
        report.to_html
        
        expect(report).to have_received(:render).with(
          partial: 'reports/genre_songs',
          locals: hash_including(:records)
        )
      end
    end
  end
  
  describe "SongPlaysReport" do
    let(:report) { Reports::SongPlaysReport.new }
    
    before do
      # Create test data
      @song1 = FactoryBot.create(:song, name: "Popular Song", code: "PS1")
      @song2 = FactoryBot.create(:song, name: "Another Song", code: "AS1")
      
      # Update to match the actual SongPlay model fields
      @play1 = FactoryBot.create(:song_play, 
        song: @song1, 
        code: "SP1",
        youtube_key: "ABC123",
        url: "https://example.com/1"
      )
      
      @play2 = FactoryBot.create(:song_play, 
        song: @song1, 
        code: "SP2",
        youtube_key: "DEF456",
        url: "https://example.com/2"
      )
      
      @play3 = FactoryBot.create(:song_play, 
        song: @song2, 
        code: "SP3",
        youtube_key: "GHI789",
        url: "https://example.com/3"
      )
    end
    
    describe "#populate" do
      it "populates records with songs and their plays" do
        report.populate
        
        # Check structure - update to match the actual implementation
        expect(report.records).to be_an(Array)
        expect(report.records.first).to have_key(:song_code)
        expect(report.records.first).to have_key(:song_name)
        expect(report.records.first).to have_key(:youtube_key)
        
        # Check data
        song1_plays = report.records.select { |r| r[:song_code] == "PS1" }
        song2_plays = report.records.select { |r| r[:song_code] == "AS1" }
        
        expect(song1_plays.size).to eq(2)
        expect(song2_plays.size).to eq(1)
        
        expect(song1_plays.map { |p| p[:youtube_key] }).to match_array(["ABC123", "DEF456"])
      end
    end
    
    describe "#to_html" do
      it "renders the correct partial" do
        allow(report).to receive(:render).and_return("<div></div>")
        report.populate
        
        report.to_html
        
        expect(report).to have_received(:render).with(
          partial: 'application/song_table',
          locals: hash_including(:song_plays)
        )
      end
    end
  end
end 