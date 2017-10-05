feature 'Races', type: :feature do
  let!(:martinborough_2014) { FactoryGirl.create(:martinborough_2014_result) }
  let(:martinborough_race) { martinborough_2014.race }
  let(:dave) { martinborough_2014.user }
  let!(:martinborough_2015) { FactoryGirl.create(:result_2015, race: martinborough_race, user: dave) }
  let!(:martinborough_2013) { FactoryGirl.create(:result_2013, race: martinborough_race, user: dave) }

  let(:ian) { FactoryGirl.create(:ian) }
  let!(:martinborough_ian_2013) { FactoryGirl.create(:result_2013, race: martinborough_race, user: ian) }

  context 'as unauthenticated user' do
    scenario 'can view all races' do
      visit races_path
      expect(page).to have_link(martinborough_race.name)
    end

    scenario 'can view all results of a race' do
      visit race_path(martinborough_race)
      expect(page).to have_content(martinborough_race.to_s)
      expect(page).to_not have_content('Your Results')
    end

    scenario 'cannot see add race button' do
      visit races_path
      expect(page).to_not have_link('Add new Race')
      expect(page).to have_link('Login to add new Race')
    end

    scenario 'cannot add a race' do
      visit new_race_path
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

    scenario 'can view all my results of a race' do
      visit race_path(martinborough_race)
      chart_canvas = page.find('canvas#result_duration_over_time_chart')

      expect(chart_canvas['data-date']).to eq '["3 Nov 2013","2 Nov 2014","1 Nov 2015"]'
      expect(chart_canvas['data-duration']).to eq [martinborough_2013, martinborough_2014, martinborough_2015].map(&:duration).to_json
      expect(chart_canvas['data-fastest-duration']).to be_present
      expect(chart_canvas['data-median-duration']).to be_present

      within '#your-results' do
        expect(page).to have_content('Your Results')
        expect(page).to have_content(martinborough_2014.duration_s)
        expect(page).to have_link(nil, href: result_path(martinborough_2015))
      end
    end

    context 'adding a race' do
      scenario 'succeeds when unique' do
        click_link 'Races'
        click_link 'Add new Race'

        fill_in 'Name', with: 'Taupo Cycle Challenge'
        fill_in 'Distance', with: '160'

        expect{ click_button 'Save' }.to change{Race.count}.by(1)

        expect(page).to have_content('Taupo Cycle Challenge (160km)')
      end

      scenario 'fails when name/distance combination is not unique' do
        click_link 'Races'
        click_link 'Add new Race'

        fill_in 'Name', with: martinborough_race.name
        fill_in 'Distance', with: martinborough_race.distance
        click_button 'Save'

        expect(page).to have_content('Name and Distance combination already exists')

        fill_in 'Distance', with: 200

        expect{ click_button 'Save' }.to_not change{Result.count}

        expect(page).to have_content("#{martinborough_race.name} (200km)")
      end
    end
  end

end
