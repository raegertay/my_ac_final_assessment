require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  let(:user) { create(:user) }
  before { sign_in user }

  describe 'POST #create' do

    before { post :create, params: note_params }

    context 'when save is successful' do
      let(:note_params) do
        { note: attributes_for(:note) }
      end
      it { expect(user.notes.count).to eq(1) }
      it { is_expected.to redirect_to(root_path) }
    end

    context 'when save is unsuccessful' do
      let(:note_params) do
        { note: attributes_for(:note, title: nil) }
      end
      it { expect(user.notes.count).to eq(0) }
      it { is_expected.to redirect_to(root_path) }
    end

  end

  describe 'PUT/PATCH #update' do

    let(:note) { create(:note, user: user) }
    before { put :update, params: { id: note.id, note: note_params } }

    context 'when update is successful' do
      let(:note_params) do
        attributes_for(:note)
      end
      it { expect(user.notes.count).to eq(1) }
      it { is_expected.to redirect_to(root_path) }
    end

    context 'when update is unsuccessful' do
      let(:note_params) do
        attributes_for(:note, title: nil)
      end
      it { is_expected.to render_template(:edit) }
    end

  end

  describe 'DELETE #destroy' do

    let(:note) { create(:note, user: user) }
    before { delete :destroy, params: { id: note.id } }
    it { expect(assigns(:note)).to be_destroyed }

  end

  describe 'POST #like' do

    let(:user2) { create(:user) }
    let(:note) { create(:note, user: user2) }
    before { post :like, params: { id: note.id } }
    it { expect(assigns(:note).total_likes).to eq(1) }
    it { is_expected.to redirect_to(root_path) }

  end

  describe 'DELETE #unlike' do

    let(:user2) { create(:user) }
    let(:note) { create(:note, user: user2) }
    before do
      note.likes.create(user: user)
      delete :unlike, params: { id: note.id }
    end
    it { expect(assigns(:note).total_likes).to eq(0) }
    it { is_expected.to redirect_to(root_path) }

  end

end
