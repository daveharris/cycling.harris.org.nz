# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

dave = User.create! email_address: "dave@harris.org.nz", password: "password"
User.create! email_address: "ian@harris.org.nz", password: "password"
puts "Created #{User.count} Users"

featherston = Race.create! name: "Wairarapa Cycle Challenge, Featherston", distance: 80
waikanae_75 = Race.create! name: "Tour of Waikanae", distance: 75
waikanae_100 = Race.create! name: "Tour of Waikanae", distance: 100
martinborough = Race.create! name: "Martinborough Charity Fun Ride", distance: 115
masterton = Race.create! name: "Tour of the Wairarapa, Masterton", distance: 115
taupo = Race.create! name: "Taupo Cycle Challenge", distance: 160
puts "Created #{Race.count} Races"

Result.create! user: dave, race: taupo, date: "27/11/2010", duration_s: "6:08:20", url: "https://www.cyclechallenge.com/results", comment: "First time at Taupo. Perfect conditions"
Result.create! user: dave, race: taupo, date: "26/11/2011", duration_s: "6:08:55", url: "https://www.cyclechallenge.com/results", comment: "Fell off after 120km :("
Result.create! user: dave, race: taupo, date: "24/11/2012", duration_s: "5:34:07", url: "https://www.cyclechallenge.com/results", comment: "Felt great for first 90km, very tired for the rest due to limited hill training"
Result.create! user: dave, race: taupo, date: "30/11/2013", duration_s: "5:36:27", url: "https://www.cyclechallenge.com/results", comment: "Felt really strong and fast. Weather v windy and pretty wet and cold. Very happy to do same time as last year as early morning training paid off"
Result.create! user: dave, race: taupo, date: "29/11/2014", duration_s: "5:12:32", url: "https://www.cyclechallenge.com/results", comment: "Personal best!"

Result.create! user: dave, race: waikanae_75, date: "10/10/2010", duration_s: "2:32:55", url: "https://results.timingsports.com/view/waikanaefunride/2010/0234", comment: "First race/bunch ride"
Result.create! user: dave, race: waikanae_100, date: "9/10/2011", duration_s: "3:04:20", url: "https://results.timingsports.com/view/waikanaefunride/2011/0106"
Result.create! user: dave, race: waikanae_100, date: "13/10/2013", duration_s: "3:06:17", url: "", comment: "New course, blustery, bright. Stayed with Dad/bunch the whole way. Felt strong"
Result.create! user: dave, race: waikanae_100, date: "12/10/2014", duration_s: "3:08:19", url: ""

Result.create! user: dave, race: martinborough, date: "30/10/2011", duration_s: "3:31:48", url: "https://results.timingsports.com/view/martinboroughfunride/2011/0354"
Result.create! user: dave, race: martinborough, date: "28/10/2012", duration_s: "3:33:58", url: "https://thetimingteamresults.co.nz/pages/result/438381"
Result.create! user: dave, race: martinborough, date: "3/11/2013", duration_s: "3:28:05", url: "https://thetimingteamresults.co.nz/pages/result/438728/"
Result.create! user: dave, race: martinborough, date: "2/11/2014", duration_s: "3:52:10", url: "https://thetimingteamresults.co.nz/pages/result/439067/", comment: "Gale North-Westerlies"

Result.create! user: dave, race: masterton, date: "14/11/2010", duration_s: "4:03:40", url: "https://results.timingsports.com/view/tourofthewairarapa/2010/0701", comment: "First 115km'er"
Result.create! user: dave, race: masterton, date: "13/11/2011", duration_s: "3:34:06", url: "https://www.sportsplits.com/races/6192/events/1/results/individuals/305", comment: "30mins faster than last year!"
Result.create! user: dave, race: masterton, date: "11/11/2012", duration_s: "3:42:48", url: "https://www.sportsplits.com/races/744/events/1/results/individuals/200", comment: "Wet and windy"
Result.create! user: dave, race: masterton, date: "17/11/2013", duration_s: "3:20:33", url: "https://www.sportsplits.com/races/2863/events/1/results/individuals/194", comment: "Windy, stayed with group for the first 80km. Fast back - felt great"
Result.create! user: dave, race: masterton, date: "5/10/2014", duration_s: "3:41:58", url: "https://www.sportsplits.com/races/6373/events/1/results/individuals/338"

Result.create! user: dave, race: featherston, date: "2/10/2011", duration_s: "2:18:38", url: "https://results.timingsports.com/view/wairarapacyclechallenge/2011/0251", comment: "Stayed with wave all the way around, fastest time ever"
Result.create! user: dave, race: featherston, date: "7/10/2012", duration_s: "2:28:00", url: "", comment: "First race of season, windy, fell off the back of 3 groups :("
Result.create! user: dave, race: featherston, date: "8/10/2013", duration_s: "2:40:02", url: "", comment: "First race of season, windy, fell off the back of 3 groups :("
Result.create! user: dave, race: featherston, date: "5/10/2014", duration_s: "2:45:09", url: "", comment: "Very strong Westerly"

puts "Created #{Race.count} Races"
