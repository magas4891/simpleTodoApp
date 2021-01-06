# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { create(:project) }
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'columns' do
    %i[id name deadline user_id created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'valid without deadline' do
    let(:project) { create(:project, deadline: nil) }

    it { is_expected.to be_valid }
  end
end
