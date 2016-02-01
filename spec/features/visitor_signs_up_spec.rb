require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
  sign_up_with 'valid@example.com', 'password'

    expect(page).to have_content('Logout')
  end
end


 def sign_up_with(username, password)
      click_button("Register")
      fill_in 'username', with: username
      fill_in 'email', with: email
      fill_in 'password', with: password
      click_button 'Create'
    end
