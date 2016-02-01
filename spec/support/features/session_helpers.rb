module Features
  module SessionHelpers
    def sign_up_with(username, password)
      click_button("Register")
      fill_in 'username', with: username
      fill_in 'email', with: email
      fill_in 'password', with: password
      click_button 'Create'
    end

    def sign_in
      user = create(:user)
      visit "/"
      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_button 'Login'
    end
  end
end
