FactoryBot.define do
  factory :user, class: User do
    name "imai"
    email "sfsdgsggsgs@gmail.com"
    password "000000"
    # worker "aaaaa"
  end
  factory :nil_name_user, class: User do
    name nil
    email "ggrgrgregerger@gmail.com"
    password "000000"
    # worker "bbbbb"
  end
end
