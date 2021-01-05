require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { FactoryBot.create(:task) }
  describe 'associations' do
    it { is_expected.to belong_to(:project) }
  end

  describe 'validations' do
    %i[description position].each do |attr|
      it { is_expected.to validate_presence_of(attr.to_sym) }
    end
    it { is_expected.to validate_uniqueness_of(:description).scoped_to(:project_id) }
  end

  describe 'columns' do
    %i[id description done project_id position created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'after create' do
    let(:task) { create(:task) }

    it { is_expected.to have_attributes(done: false) }
  end
end
