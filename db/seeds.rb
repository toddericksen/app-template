# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 10.times do
#   Company.create(
#     domain: Faker::Internet.domain_name,
#     name: Faker::Company.name,
#     logo: Faker::Avatar.image
#   )
# end

# 20.times do
#   Location.create(
#     company_id: rand(1..10),
#     name: Faker::Travel::TrainStation.name(region: 'united_kingdom', type: 'metro'),
#     city: Faker::Address.city,
#     street: Faker::Address.street_address,
#     postal_code: Faker::Address.zip,
#     state: Faker::Address.state,
#     country: Faker::Address.country
#   )
# end

# 30.times do
#   password = '123456789'

#   User.create(
#     company_id: rand(1..10),
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.unique.email,
#     mobile: Faker::PhoneNumber.unique.cell_phone,
#     job_title: Faker::Job.title,
#     password: password,
#     password_confirmation: password
#   )
# end
