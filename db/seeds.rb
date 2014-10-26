# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

dave = User.create(first_name: 'Dave', last_name: 'Harris', email: 'dave@harris.org.nz', password: 'changeme')
ian = User.create(first_name: 'Ian', last_name: 'Harris', email: 'ian@harris.org.nz', password: 'changeme')

featherston   = Race.create(name: 'Wairarapa Cycle Challenge, Featherston', distance: 80, url: 'http://www.wvcc.org.nz')
waikanae      = Race.create(name: 'Tour of Waikanae', distance: 100, url: 'http://www.tourofwaikanae.co.nz/')
martinborough = Race.create(name: 'Martinborough Charity Fun Ride', distance: 115, url: 'http://www.mcfr.org.nz/')
masterton     = Race.create(name: 'Tour of the Wairarapa, Masterton', distance: 115, url: 'http://techs.net.nz/trusthouse.co.nz/sport/athletics/cycle_tour_of_the_wairarapa.htm')
taupo         = Race.create(name: 'Taupo Cycle Challenge', distance: 160, url: 'http://cyclechallenge.com')

Result.create(user: dave, race: taupo, 
  date: Date.parse('30/11/2013'), duration: Duration.new(hours: 5, minutes: 36, seconds: 27).format('%ts'), 
  comment: 'Felt really strong and fast. Weather v windy and pretty wet and cold. Very happy to do same time as last year as early morning training paid off', 
  timing_url: 'http://www.thetimingteam.co.nz/results/index.php?thread=1401729240&strand=1709452633&instance=2755')

Result.create(user: dave, race: featherston, 
  date: Date.parse('5/10/2014'), duration: Duration.new(hours: 2, minutes: 45, seconds: 9).format('%ts'), 
  comment: 'Very strong Westerly', timing_url: 'http://www.thetimingteam.co.nz/results/index.php?thread=1565443774&strand=2080245111&instance=376')
