FactoryBot.define do
  factory :project do
    user { create(:user) }
    name { Faker::TvShows::FamilyGuy.character }
    deadline { Faker::Date.in_date_period }
  end
end

