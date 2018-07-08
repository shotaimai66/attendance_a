# ユーザー
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             team: "kannrisya",
             specified_work_time: Time.zone.local(2018, 6, 30, 8,0),
             basic_work_time: Time.zone.local(2018, 6, 30, 7,30),
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "今井　翔太",
             email: "changemymind6@gmail.com",
             team: "syouta",
             password:              "shota6",
             password_confirmation: "shota6",
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  team = "syouta"
  password = "password"
  User.create!(name:  name,
               email: email,
               team: team,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# works
days = (Date.new(2018,5).all_month)
users = User.order(:created_at).take(2)
start_time = Time.new(2018, 5, 30, 9, 00, 00)
end_time = Time.new(2018, 5, 30, 17, 15, 00)
  users.each do |user|
    days.each do |day|
      user.works.create!(day: day,
          start_time: start_time,
          end_time: end_time)
    end
  end


