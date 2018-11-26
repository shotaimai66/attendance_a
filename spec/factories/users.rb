FactoryBot.define do
  factory :user, class: User do
    name "imai"
    email "sfsdgsggsgs@gmail.com"
    password "000000"
    # worker "aaaaa"
  end
  factory :another, class: User do
    name "syouta"
    email "changem@gmail.com"
    password "fpoaopfkpkap"
    # worker "bbbbb"
  end
  
end
