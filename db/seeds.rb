# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

User.create(email_address: "dave@harris.org.nz", password: "password")
User.create(email_address: "ian@harris.org.nz", password: "password")
puts "Created #{User.count} Users"

Race.create(name: "Wairarapa Cycle Challenge, Featherston", distance: 80)
Race.create(name: "Tour of Waikanae", distance: 100)
Race.create(name: "Martinborough Charity Fun Ride", distance: 115)
Race.create(name: "Tour of the Wairarapa, Masterton", distance: 115)
Race.create(name: "Taupo Cycle Challenge", distance: 160)
puts "Created #{Race.count} Race"
