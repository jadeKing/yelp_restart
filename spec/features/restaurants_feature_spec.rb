require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'no restaurants yet'
      expect(page).to have_link 'add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'no restaurants yet'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form and shows the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create restaurant'
      expect(page).to have_content 'KFC'
      expect(page).to eq '/restaurants'
    end
  end
end
