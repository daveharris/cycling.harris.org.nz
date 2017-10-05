feature 'Results', type: :feature do
  let!(:martinborough_2014) { FactoryGirl.create(:martinborough_2014_result) }
  let(:martinborough_race) { martinborough_2014.race }
  let(:dave) { martinborough_2014.user }
  let!(:martinborough_2015) { FactoryGirl.create(:result_2015, race: martinborough_race, user: dave) }
  let!(:martinborough_2013) { FactoryGirl.create(:result_2013, race: martinborough_race, user: dave) }

  let(:ian) { FactoryGirl.create(:ian) }
  let!(:martinborough_ian_2013) { FactoryGirl.create(:result_2013, race: martinborough_race, user: ian) }

  context 'as unauthenticated user' do
    scenario 'can view all results' do
      visit results_path
      expect(page).to have_css('.row.result', count: Result.count)
    end

    scenario 'can filter results' do
      taupo_race = FactoryGirl.create(:taupo_race)

      visit results_path

      click_button 'Apply Filter'
      expect(page).to have_css('.row.result', count: Result.count)

      select dave.to_s, from: 'result_user_id'
      select taupo_race.to_s, from: 'result_race_id'
      click_button 'Apply Filter'
      expect(page).to have_css('row.result', count: taupo_race.results.count)
    end

    scenario 'can view a result' do
      visit result_path(martinborough_2014)
      expect(page).to have_link(martinborough_race.name)
    end

    scenario 'cannot see add result button' do
      visit results_path
      expect(page).to_not have_link('Add new Results')
      expect(page).to have_link('Login to add new Result(s)')
    end

    scenario 'cannot add a result' do
      visit new_result_path
      expect(page).to have_current_path(sign_in_path)
    end
  end

  context 'as authenticated user' do
    before(:each) do
      login_as(dave)
    end

    scenario 'is logged in' do
      expect(page).to have_content("Logged in as #{dave.first_name}")
    end

    scenario 'can view the previous result' do
      visit result_path(martinborough_2014)

      within '.result-dave-harris-martinborough-charity-fun-ride-2014' do
        expect(page).to have_content('24:05 than previous') # duration
        expect(page).to have_content('2:36 than previous')  # fastest
        expect(page).to have_content('17:37 than previous') # median
      end
      within '.result-dave-harris-martinborough-charity-fun-ride-2013' do
        expect(page).to have_content('Previous Result')
        within '.panel-body' do
          expect(page).to have_content('1st Result')
        end
      end
    end

    scenario 'can view your personal best result' do
      visit result_path(martinborough_2014)

      within '.result-dave-harris-martinborough-charity-fun-ride-2014' do
        expect(page).to have_content('24:48 than Personal Best') # duration
      end
      within '.result-dave-harris-martinborough-charity-fun-ride-2015' do
        expect(page).to have_content('Personal Best')
      end
    end

  end

end
