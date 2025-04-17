require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:songs) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:code).is_at_most(Genre.max_code_length) }
    it { should validate_length_of(:name).is_at_most(Genre.max_name_length) }
  end

  describe '.max_name_length' do
    it 'returns 12' do
      expect(Genre.max_name_length).to eq(12)
    end
  end
end 