require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:movies) }
    it { should have_and_belong_to_many(:genres) }
    it { should have_and_belong_to_many(:performers) }
    it { should have_and_belong_to_many(:writers) }
    it { should have_and_belong_to_many(:rights_admin_orgs).class_name('Organization') }
    it { should have_many(:song_plays) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:code).is_at_most(Song.max_code_length) }
    it { should validate_length_of(:name).is_at_most(Song.max_name_length) }
  end

  describe '.max_name_length' do
    it 'returns 50' do
      expect(Song.max_name_length).to eq(50)
    end
  end

  describe '#add_genre' do
    let(:song) { create(:song) }
    let(:genre) { create(:genre) }

    context 'when the genre exists' do
      it 'adds the genre to the song' do
        expect {
          song.add_genre(genre.code)
        }.to change { song.genres.count }.by(1)
        
        expect(song.genres).to include(genre)
      end

      it 'does nothing if the genre is already added' do
        song.genres << genre
        
        expect {
          song.add_genre(genre.code)
        }.not_to change { song.genres.count }
      end
    end

    context 'when the genre does not exist' do
      it 'raises an error' do
        expect {
          song.add_genre('nonexistent')
        }.to raise_error(RuntimeError, /Genre for code nonexistent not found/)
      end
    end
  end

  describe '#performer_codes' do
    let(:song) { create(:song) }
    let(:performer1) { create(:performer, code: 'perf1') }
    let(:performer2) { create(:performer, code: 'perf2') }

    it 'returns sorted performer codes' do
      song.performers << performer2
      song.performers << performer1
      
      expect(song.performer_codes).to eq(['perf1', 'perf2'])
    end
  end

  describe '#genre_codes' do
    let(:song) { create(:song) }
    let(:genre1) { create(:genre, code: 'gen1') }
    let(:genre2) { create(:genre, code: 'gen2') }

    it 'returns sorted genre codes' do
      song.genres << genre2
      song.genres << genre1
      
      expect(song.genre_codes).to eq(['gen1', 'gen2'])
    end
  end
end 