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
      sign_up('test@test.com', 'testtest')
      visit '/restaurants'
      click_link 'add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'a user not signed in clicks add restaurant' do
      it 'prompts you to sign in' do
        visit '/'
        click_link 'add a restaurant'
        expect(page).to have_content 'Log in'
        expect(current_path).to eq '/users/sign_in'
      end
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a form that is too short' do
        sign_up('test@test.com', 'testtest')
        visit '/restaurants'
        click_link 'add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

  end

  context 'viewing restauarants' do
    let!(:kfc) { Restaurant.create(name: 'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    scenario 'let a user edit a restaurant' do
      sign_up('test@test.com', 'testtest')
      Restaurant.create name: 'KFC'
      visit '/restaurants'
      click_link 'edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleteing restaurants' do
    scenario 'user clicks delete and removes restaurant' do
      sign_up('test@test.com', 'testtest')
      Restaurant.create name: 'KFC'
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  def sign_up(email, password)
    visit 'users/sign_up'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'
  end







end
