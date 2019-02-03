require "rails_helper"

RSpec.feature "User Sign up", :type => :feature do

  scenario "with valid email and password" do
    visit new_user_registration_path #'/users/sign_in'
    expect(page.current_path).to eql(new_user_registration_path)
    fill_in 'Email', with: 'test@cox.net'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully'
  end

  scenario "with invalid email and valid password" do
    visit new_user_registration_path #'/users/sign_in'
    expect(page.current_path).to eql(new_user_registration_path)
    fill_in 'Email', with: 'test.net'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content "Email is invalid"
  end

  scenario "with valid email and invalid password" do
    visit new_user_registration_path #'/users/sign_in'
    expect(page.current_path).to eql(new_user_registration_path)
    fill_in 'Email', with: 'test@cox.net'
    fill_in 'Password', with: 'p'
    fill_in 'Password confirmation', with: 'p'
    click_button 'Sign up'
    expect(page).to have_content "Password is too short"
  end

end
