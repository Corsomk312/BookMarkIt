require 'rails_helper'
# require 'capybara/rspec'
# require 'capybara/dsl'

feature 'home page' do
  scenario 'welcomes the user' do
    visit '/'
    expect(page).to have_content 'Welcome'
  end
end

feature 'registration page' do
  scenario 'can register as a user' do
    visit '/users/new'
    within('#create-user') do
      fill_in "username", with: "ronny"
      fill_in "email", with: "ronny@gmail.com"
      fill_in "password", with: "password"
    end
    click_button "Create"
    expect(page).to have_content "Successfully registered!"

  end
end


