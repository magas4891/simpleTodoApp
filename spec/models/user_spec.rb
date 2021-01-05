# frozen_string_literal: true
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:projects) }
  end

  describe 'validations' do
    %i[email password].each do |attr|
      it { is_expected.to validate_presence_of(attr.to_sym) }
    end
  end

  describe 'columns' do
    %i[id email encrypted_password reset_password_token reset_password_sent_at remember_created_at created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'email format validations' do
    it { is_expected.to allow_value("example@mail.com").for(:email) }
    it { is_expected.to_not allow_value("example").for(:email) }
  end
end
