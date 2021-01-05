FactoryBot.define do
  factory :task do
    project
    description { Faker::TvShows::FamilyGuy.quote }
    position { 0 }
  end
end
