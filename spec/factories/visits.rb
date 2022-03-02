FactoryBot.define do
  factory :visit do
    date { DateTime.current }
    status { "realizado" }
    user
    checkin_at { DateTime.yesterday }
    checkout_at { DateTime.tomorrow.tomorrow }
  end
end
