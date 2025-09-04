# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

dave = User.create(first_name: 'Dave', last_name: 'Harris', email: 'dave@harris.org.nz', password: 'changeme')
ian = User.create(first_name: 'Ian', last_name: 'Harris', email: 'ian@harris.org.nz', password: 'changeme')

featherston   = Race.create(name: 'Wairarapa Cycle Challenge, Featherston', distance: 80)
waikanae      = Race.create(name: 'Tour of Waikanae', distance: 100)
martinborough = Race.create(name: 'Martinborough Charity Fun Ride', distance: 115)
masterton     = Race.create(name: 'Tour of the Wairarapa, Masterton', distance: 115)
taupo         = Race.create(name: 'Taupo Cycle Challenge', distance: 160)
