namespace :dev do
  task fake: :environment do
    Restaurant.destroy_all
    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end
    puts "now you have #{Restaurant.count} restaurants data"

    User.destroy_all

    # Default admin
    User.create(name: "Max", email: "max@max.com", password: "000000", role: "admin")
    puts "Default admin created!"

    20.times do |i|
      User.create(
        name: FFaker::Name.name,
        email: "user#{i+1}@max.com",
        password: "000000",
        intro: FFaker::Lorem.paragraph
        )
    end
    puts "now you have #{User.count} user data"


    Comment.destroy_all
    1000.times do |i|
      Comment.create(
        content: FFaker::Lorem.sentence,
        restaurant_id: rand(Restaurant.first.id..Restaurant.last.id),
        user_id: rand(User.first.id..User.last.id)
        )
    end
    puts "now you have #{Comment.count} comments data"

    Favorite.destroy_all
    1000.times do |i|
      Favorite.create(
        restaurant_id: rand(Restaurant.first.id..Restaurant.last.id),
        user_id: rand(User.first.id..User.last.id)
        )
    end

    puts "now you have #{Favorite.count} favorites data"


    Restaurant.all.each do |r|
      r.update_favorites
    end
    puts "now all restaurant favorites count were updated"


    Like.destroy_all
    1000.times do |i|
      Like.create(
        restaurant_id: rand(Restaurant.first.id..Restaurant.last.id),
        user_id: rand(User.first.id..User.last.id)
        )
    end
    puts "now you have #{Like.count} likes data"

  end
end
