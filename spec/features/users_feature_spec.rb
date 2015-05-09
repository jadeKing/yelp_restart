require 'rails_helper'

context 'user on the homepage and not signed in' do
  it 'has sign in and a sign up links' do
    visit '/'
    expect(page).to have_link 'Sign in'
    expect(page).to have_link 'Sign up'
  end

  it 'does not show the sign out link' do
    visit '/'
    expect(page).not_to have_link 'Sign out'
  end
end
context 'user signed in on the homepage' do
  before do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    click_button 'Sign up'
  end

  it 'shows the sign out link' do
    visit '/'
    expect(page).to have_link 'Sign out'
  end

  it 'does not show the sign up or sign in link' do
    visit '/'
    expect(page).not_to have_link 'Sign in'
    expect(page).not_to have_link 'Sign up'
  end
end
