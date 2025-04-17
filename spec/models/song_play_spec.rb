require 'rails_helper'

RSpec.describe SongPlay, type: :model do
  describe 'associations' do
    it { should belong_to(:song) }
    it { should have_and_belong_to_many(:performers) }
  end

  describe 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
    it { should validate_length_of(:code).is_at_most(SongPlay.max_code_length) }
    it { should validate_presence_of(:song) }
  end

  describe 'constants' do
    it 'defines YOUTUBE_KEY_LENGTH' do
      expect(SongPlay::YOUTUBE_KEY_LENGTH).to eq(11)
    end

    it 'defines YOUTUBE_WATCH_URL_LENGTH' do
      expect(SongPlay::YOUTUBE_WATCH_URL_LENGTH).to eq(43)
    end

    it 'defines YOUTUBE_EMBED_URL_LENGTH' do
      expect(SongPlay::YOUTUBE_EMBED_URL_LENGTH).to eq(41)
    end
  end

  describe 'scopes' do
    describe '.best' do
      let!(:best_song_play) { create(:song_play, code: SongPlay.best_codes.first) }
      let!(:regular_song_play) { create(:song_play, code: 'not-in-best-list') }

      it 'returns song plays with codes in the best_codes list' do
        expect(SongPlay.best).to include(best_song_play)
        expect(SongPlay.best).not_to include(regular_song_play)
      end
    end

    describe '.elvis' do
      let!(:elvis) { create(:performer, code: 'elvis') }
      let!(:other_performer) { create(:performer, code: 'other') }
      
      let!(:elvis_song_play) do
        sp = create(:song_play)
        sp.performers << elvis
        sp
      end
      
      let!(:other_song_play) do
        sp = create(:song_play)
        sp.performers << other_performer
        sp
      end

      it 'returns song plays performed by Elvis' do
        expect(SongPlay.elvis).to include(elvis_song_play)
        expect(SongPlay.elvis).not_to include(other_song_play)
      end
    end
  end

  describe '.max_code_length' do
    it 'returns 25' do
      expect(SongPlay.max_code_length).to eq(25)
    end
  end

  describe '.youtube_watch_url' do
    it 'returns a formatted YouTube watch URL' do
      expect(SongPlay.youtube_watch_url('VIDEO_KEY')).to eq('https://www.youtube.com/watch?v=VIDEO_KEY')
    end
  end

  describe '#youtube_watch_url' do
    it 'returns a watch URL for the song play' do
      song_play = build_stubbed(:song_play, youtube_key: 'ABC123')
      expect(song_play.youtube_watch_url).to eq('https://www.youtube.com/watch?v=ABC123')
    end
  end

  describe '.youtube_embed_url' do
    it 'returns a formatted YouTube embed URL' do
      expect(SongPlay.youtube_embed_url('VIDEO_KEY')).to eq('https://www.youtube.com/embed/VIDEO_KEY')
    end
  end

  describe '#youtube_embed_url' do
    it 'returns an embed URL for the song play' do
      song_play = build_stubbed(:song_play, youtube_key: 'ABC123')
      expect(song_play.youtube_embed_url).to eq('https://www.youtube.com/embed/ABC123')
    end
  end

  describe '.best_codes' do
    it 'returns an array of codes' do
      expect(SongPlay.best_codes).to be_an(Array)
      expect(SongPlay.best_codes).not_to be_empty
      expect(SongPlay.best_codes.first).to eq('red-roses.andy-wms')
    end

    it 'memoizes the result' do
      original = SongPlay.best_codes
      expect(SongPlay.instance_variable_get(:@best_codes)).to eq(original)
      expect(SongPlay.best_codes.object_id).to eq(original.object_id)
    end
  end
end 