require 'rails_helper'
# require 'capybara/rspec'
# require 'capybara/dsl'

feature 'home page' do
  scenario 'welcomes the user' do
    visit '/'
    expect(page).to have_content 'Bookmark It!'
  end
end

feature 'registration page' do
  scenario 'can register as a user' do
    visit '/users/new'
    within('#create-user') do
      fill_in "username", with: "test"
      fill_in "email", with: "test@gmail.com"
      fill_in "password", with: "password"
    end
    click_button "Create"
    expect(page).to have_content "Successfully registered and logged in!"

  end
end

feature 'upon logged in a user can' do
  before :each do
    User.create!(:username => "ronny", :email =>"ronny@gmail.com", :password => "ronny")
  end

  scenario 'can login as user' do
    login
    expect(page).to have_content "Successfully logged in!"
  end

  scenario 'create a new list' do
    login
    visit '/lists/new'

    within('#create-list') do
      fill_in "list_name", with: "List"
    end
    click_button "Create"
    expect(page).to have_content "List successfully created!"
  end
end

def login
  visit '/'
   within('.navbar-form') do
      fill_in 'username', with: "ronny"
      fill_in 'password', with: "ronny"
    end
  click_button "Login"
end

