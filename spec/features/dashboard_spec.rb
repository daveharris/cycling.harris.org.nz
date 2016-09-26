feature 'Dashboard', type: :feature do
  let!(:martinborough_2014) { FactoryGirl.create(:martinborough_2014_result) }
  let(:martinborough_race) { martinborough_2014.race }
  let(:dave) { martinborough_2014.user }
  let!(:martinborough_2015) { FactoryGirl.create(:result_2015, race: martinborough_race, user: dave) }
  let!(:martinborough_2013) { FactoryGirl.create(:result_2013, race: martinborough_race, user: dave) }

  let(:ian) { FactoryGirl.create(:ian) }
  let!(:martinborough_ian_2013) { FactoryGirl.create(:result_2013, race: martinborough_race, user: ian) }

  context 'as unauthenticated user' do
    scenario 'can view statistics for all users' do
      visit root_path

      expect(page).to have_content("Welcome to your dashboard")
      expect(page).to have_content("Results: 4")
      total_distance = [martinborough_2014, martinborough_2015, martinborough_2013, martinborough_ian_2013].sum{|r| r.race.distance}
      expect(page).to have_content("Distance: #{total_distance} km")
    end
  end

  context 'as authenticated user' do
    before(:each) do
      login_as(dave)
    end

    scenario 'can view statistics for current user' do
      visit root_path

      expect(page).to have_content("Dave, welcome to your dashboard")
      expect(page).to have_content("Results: 3")
      total_distance = [martinborough_2014, martinborough_2015, martinborough_2013].sum{|r| r.race.distance}
      expect(page).to have_content("Distance: #{total_distance} km")
    end
  end

end
