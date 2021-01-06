# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    project
    description { Faker::Book.title }
    position { 0 }
  end
end
