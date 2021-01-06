# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let!(:user) { create(:user) }
  let(:params) do
    attributes_for(
      :project,
      name: 'Learn web-development',
      deadline: Date.today + 1.day
    )
  end

  describe 'POST#create' do
    let(:send_request) { post :create, params: { project: params }, format: :js }

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

      it { expect(response.content_type).to eq 'text/javascript; charset=utf-8' }
      it { is_expected.to respond_with :ok }
      it { expect(Project.count).to eq(1) }
      it { expect(Project.last.name).to eq('Learn web-development') }
      it { expect(Project.last.user_id).to eq(user.id) }
    end
  end

  describe 'PATCH#update' do
    let!(:project) { create(:project) }
    let(:send_request) do
      patch :update,
            params: {
              id: project,
              project: params
            },
            as: :js
    end

    context 'user not authenticated' do
      before { send_request }

      it { is_expected.to respond_with :unauthorized }
    end

    context 'user signed in' do
      before do
        sign_in user
        send_request
      end

      it { expect(response.content_type).to eq 'text/javascript; charset=utf-8' }
      it { is_expected.to respond_with :ok }
      it { expect(project.reload.name).to eq('Learn web-development') }
      it { expect(project.reload.deadline).to eq(Date.today + 1.day) }

      context 'invalid id' do
        it do
          expect do
            patch :update,
                  params: { id: 'unknown' },
                  as: :js
          end
            .to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
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
      it { expect(response.content_type).to eq 'text/javascript; charset=utf-8' }

      context 'invalid id' do
        it do
          expect do
            delete :destroy,
                   params: { id: 'unknown' },
                   as: :js
          end
            .to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
