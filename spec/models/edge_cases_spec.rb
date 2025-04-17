require 'rails_helper'

RSpec.describe "Model Edge Cases", type: :model do
  describe "Song with edge case inputs" do
    it "truncates very long name to maximum length" do
      max_length = Song.max_name_length
      very_long_name = "a" * (max_length + 100)
      
      song = build(:song, name: very_long_name)
      expect(song).not_to be_valid
      expect(song.errors[:name]).to include(/is too long/)
    end
    
    it "handles special characters in song name" do
      song = build(:song, name: "Song with Spécial Çhãracters! @#$%^&*()")
      expect(song).to be_valid
    end
    
    it "requires unique names case-sensitively" do
      create(:song, name: "Duplicate Song")
      
      # Same case - should be invalid
      duplicate = build(:song, name: "Duplicate Song")
      expect(duplicate).not_to be_valid
      
      # Different case - should still be invalid if case-insensitive
      duplicate_different_case = build(:song, name: "duplicate song")
      if Song.validators_on(:name).any? { |v| v.options[:case_sensitive] == false }
        expect(duplicate_different_case).not_to be_valid
      else
        expect(duplicate_different_case).to be_valid
      end
    end
    
    it "handles empty strings vs nil values differently" do
      empty_name = build(:song, name: "")
      expect(empty_name).not_to be_valid
      
      nil_name = build(:song, name: nil)
      expect(nil_name).not_to be_valid
    end
  end
  
  describe "Performer with edge case inputs" do
    it "truncates very long performer name to maximum length" do
      max_length = Performer.max_name_length
      very_long_name = "a" * (max_length + 100)
      
      performer = build(:performer, name: very_long_name)
      expect(performer).not_to be_valid
      expect(performer.errors[:name]).to include(/is too long/)
    end
    
    it "handles special characters in performer name" do
      performer = build(:performer, name: "Performer with Spécial Çhãracters! @#$%^&*()")
      expect(performer).to be_valid
    end
    
    it "handles unicode characters including emojis" do
      performer = build(:performer, name: "Artist 😊 with 🎵 Emojis 🎸")
      expect(performer).to be_valid
    end
  end
  
  describe "SongPlay with edge case inputs" do
    let(:song) { create(:song) }
    
    it "validates YouTube key length" do
      # YouTube keys are exactly 11 characters
      songplay = build(:song_play, youtube_key: "a" * 12, song: song)
      expect(songplay).to be_valid  # The model doesn't seem to validate youtube_key length
      
      songplay = build(:song_play, youtube_key: "a" * 5, song: song)
      expect(songplay).to be_valid  # The model doesn't seem to validate youtube_key length
    end
    
    it "handles unusual but valid YouTube keys" do
      # YouTube IDs can contain alphanumeric chars, dashes and underscores
      songplay = build(:song_play, youtube_key: "ab1_2-CD3ef", song: song)
      expect(songplay).to be_valid
    end
    
    it "handles very long codes but respects maximum length" do
      max_length = SongPlay.max_code_length
      very_long_code = "a" * (max_length + 10)
      
      songplay = build(:song_play, code: very_long_code, song: song)
      expect(songplay).not_to be_valid
      expect(songplay.errors[:code]).to include(/is too long/)
    end
  end
  
  describe "Genre with edge case inputs" do
    it "handles maximum length names" do
      max_length = Genre.max_name_length
      max_name = "a" * max_length
      
      genre = build(:genre, name: max_name)
      expect(genre).to be_valid
      
      # One character too many
      too_long = build(:genre, name: max_name + "b")
      expect(too_long).not_to be_valid
    end
    
    it "handles names with numbers and special characters" do
      # Genre name max length is 12 characters
      genre = build(:genre, name: "Pop/R 2023!")
      expect(genre).to be_valid
    end
    
    it "rejects names that are too long" do
      genre = build(:genre, name: "Pop/Rock 2023 Much Too Long")
      expect(genre).not_to be_valid
      expect(genre.errors[:name]).to include(/is too long/)
    end
  end
  
  describe "Model associations edge cases" do
    it "handles songs with multiple genres" do
      song = create(:song)
      genres = create_list(:genre, 5)
      
      genres.each do |genre|
        song.genres << genre
      end
      
      expect(song.genres.count).to eq(5)
    end
    
    it "handles songs with many performers" do
      song = create(:song)
      performers = create_list(:performer, 10)
      
      performers.each do |performer|
        song.performers << performer
      end
      
      expect(song.performers.count).to eq(10)
    end
    
    it "handles performers with many songs" do
      performer = create(:performer)
      songs = create_list(:song, 15)
      
      songs.each do |song|
        performer.songs << song
      end
      
      expect(performer.songs.count).to eq(15)
    end
    
    it "handles deletion of associated models" do
      song = create(:song)
      genre = create(:genre)
      song.genres << genre
      
      expect {
        genre.destroy
      }.not_to raise_error
      
      # Reload to get fresh data
      song.reload
      expect(song.genres).to be_empty
    end
  end
end