require 'rails_helper'

RSpec.describe Note, type: :model do

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }

  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }
  let(:user2) { create(:user) }
  before { note.likes.create(user: user2) }

  describe '#liked?' do
    it { expect(note.liked?(user2)).to eq(true) }
  end

  describe '#total_likes' do
    it { expect(note.total_likes).to eq(1) }
  end

end
