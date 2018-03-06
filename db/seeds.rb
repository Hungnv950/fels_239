User.create!(
  name: "Example User",
  email: "example@railstutorial.org",
  password: "password",
  password_confirmation: "password",
  is_admin: true,
  activated: true,
  activated_at: Time.zone.now)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end

30.times do |n|
  name = Faker::Name.name
  Category.create!(name: name)
end

10.times do |n|
  name = Faker::Name.name
  Word.create!(
    content: name,
    category_id: 28,
    answers_attributes:
      { 0 =>
          {
              content: name,
              is_correct: true
          },
        1 =>
          {
              content: name+"AN",
              is_correct: false
          },
        2 =>
        {
            content: name+"A",
            is_correct: false
        }
      }
    )
end
