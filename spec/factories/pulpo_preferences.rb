FactoryBot.define do
  factory :pulpo_preference, class: 'Pulpo::Preference' do
    value { "MyText" }
    key { "MyString" }
  end
end
