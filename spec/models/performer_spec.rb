require 'rails_helper'

RSpec.describe Performer, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:songs) }
    it { should have_and_belong_to_many(:song_plays) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:code).is_at_most(Performer.max_code_length) }
    it { should validate_length_of(:name).is_at_most(Performer.max_name_length) }
  end

  describe '.max_name_length' do
    it 'returns 60' do
      expect(Performer.max_name_length).to eq(60)
    end
  end
end 