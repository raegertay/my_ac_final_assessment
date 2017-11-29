require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }
  before { sign_in user }

  describe 'POST #follow' do
    let(:user2) { create(:user) }
    before { post :follow, params: { id: user2.id } }
    it { expect(user.followees.count).to eq(1) }
    it { is_expected.to redirect_to(root_path) }
  end

  describe 'DELETE #unfollow' do
    let(:user2) { create(:user) }
    before do
      user.follow(user2)
      delete :unfollow, params: { id: user2.id }
    end
    it { expect(user.followees.count).to eq(0) }
    it { is_expected.to redirect_to(root_path) }
  end

end
