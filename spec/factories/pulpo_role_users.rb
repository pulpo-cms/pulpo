FactoryBot.define do
  factory :pulpo_role_user, class: 'Pulpo::RoleUser' do
    role { nil }
    user { nil }
  end
end
