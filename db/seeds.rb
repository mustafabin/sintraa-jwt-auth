puts "🧼 Wiping DB ..."

User.destroy_all
Product.destroy_all

puts "🌱 Seeding ..."

10.times do 
    User.create!(email:"#{Faker::Name.unique.name}@mail.com",password:"123")
    Product.create!(name:Faker::Appliance.equipment,price:rand(1..100), user_id: User.all.sample.id)
end

# Seed your database here

puts "✅ Done seeding!"
