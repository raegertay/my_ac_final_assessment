require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to have_many(:followings).with_foreign_key(:follower_id).dependent(:destroy) }
  it { is_expected.to have_many(:followees).through(:followings) }
  it { is_expected.to have_many(:inverse_followings).class_name('Following').with_foreign_key(:followee_id).dependent(:destroy) }
  it { is_expected.to have_many(:followers).through(:inverse_followings) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }

  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  describe '#follow' do
    before { user.follow(user2) }
    it { expect(user.followees).to contain_exactly(user2) }
  end

  describe '#unfollow' do
    before do
      user.follow(user2)
      user.unfollow(user2)
    end
    it { expect(user.followees.count).to eq(0) }
  end

  describe '#following?' do
    before { user.follow(user2) }
    it { expect(user.following?(user2)).to eq(true) }
  end

  describe '#name' do
    let(:user2) { create(:user, email: 'test123@email.com') }
    it { expect(user2.name).to eq('test123') }
  end

  describe '#followee_notes' do
    let!(:note) { create(:note, user: user2) }
    before { user.follow(user2) }
    it { expect(user.followee_notes.count).to eq(1) }
  end

end
