require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { { project: {
    name: "Learn web-development"
  }
  } }

  describe 'POST#create' do
    let(:send_request) { post :create, params: params, format: :js }

    context 'user not authenticated' do
      before { send_request }

      it { is_expected.to respond_with :unauthorized }
      it { expect(Project.count).to eq(0) }
    end

    context 'user signed in' do
      before do
        sign_in user
        send_request
      end

      it { expect(response.content_type).to eq "text/javascript; charset=utf-8" }
      it { is_expected.to respond_with :ok }
      it { expect(Project.count).to eq(1) }
      it { expect(Project.last.name).to eq("Learn web-development") }
      it { expect(Project.last.user_id).to eq(user.id) }
    end
  end

  describe 'PATCH#update' do
    let(:project) { create(:project, name: "What to do?", deadline: Date.today - 1.day) }
    let(:params) { attributes_for(:project, name: "Learn web-development", deadline: Date.today + 1.day) }
    let(:send_request) { patch :update,
                               params: {
                                 id: project,
                                 project: params
                               },
                               as: :js }

    context 'user not authenticated' do
      before { send_request }

      it { is_expected.to respond_with :unauthorized }
    end

    context 'user signed in' do
      before do
        sign_in user
        send_request
      end

      it { expect(response.content_type).to eq "text/javascript; charset=utf-8" }
      it { is_expected.to respond_with :ok }
      it { expect(project.reload.name).to eq("Learn web-development") }
      it { expect(project.reload.deadline).to eq(Date.today + 1.day) }
    end
  end

  describe "DELETE #destroy" do
    let(:project) { create(:project) }
    let(:send_request) { delete :destroy, params: { id: project }, as: :js }

    context 'user not authenticated' do
      before { send_request }

      it { is_expected.to respond_with :unauthorized }
    end

    context 'user signed in' do
      before do
        sign_in user
        send_request
      end

      it { expect(Project.count).to eq(0) }
      it { is_expected.to respond_with :success }
      it { expect(response.content_type).to eq "text/javascript; charset=utf-8" }
    end
  end
end
