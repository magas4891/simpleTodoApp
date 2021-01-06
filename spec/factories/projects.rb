# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    user
    name { Faker::Book.title }
    deadline { Faker::Date.in_date_period }
  end
end
