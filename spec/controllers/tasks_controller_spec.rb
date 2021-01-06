# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }
  let(:params) do
    attributes_for(
      :task,
      description: 'Learn HTML',
      project_id: project
    )
  end

  describe 'POST#create' do
    let(:send_request) { post :create, params: { task: params }, format: :js }

    context 'user not authenticated' do
      before { send_request }

      it { is_expected.to respond_with :unauthorized }
      it { expect(Task.count).to eq(0) }
    end

    context 'sign in' do
      before do
        sign_in user
        send_request
      end

      it { expect(response.content_type).to eq 'text/javascript; charset=utf-8' }
      it { is_expected.to respond_with :ok }
      it { expect(Task.count).to eq(1) }
      it { expect(Task.last.description).to eq('Learn HTML') }
      it { expect(Task.last.done).to be_falsey }
      it { expect(Task.last.position).to eq(0) }
      it { expect(Task.last.project_id).to eq(project.id) }
    end
  end

  describe 'PATCH#update' do
    let!(:task) { create(:task) }
    let(:params) do
      attributes_for(
        :task,
        description: 'Learn HTML',
        done: true,
        position: 2,
        project_id: project
      )
    end
    let(:send_request) do
      patch :update,
            params: {
              id: task,
              task: params
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
      it { expect(task.reload.description).to eq('Learn HTML') }
      it { expect(task.reload.done).to be_truthy }
      it { expect(task.reload.position).to eq(2) }

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
    let(:task) { create(:task) }
    let(:send_request) { delete :destroy, params: { id: task }, as: :js }

    context 'user not authenticated' do
      before { send_request }

      it { is_expected.to respond_with :unauthorized }
    end

    context 'user signed in' do
      before do
        sign_in user
        send_request
      end

      it { expect(Task.count).to eq(0) }
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
