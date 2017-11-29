require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #dashboard' do

    let(:note) { create(:note, user: user) }
    let(:user2) { create(:user) }

    before do
      get :dashboard
    end

    it { expect(assigns(:note)).to be_a_new(Note) }
    it { expect(assigns(:notes)).to contain_exactly(note) }
    it { expect(assigns(:users)).to contain_exactly(user2) }

  end

end
