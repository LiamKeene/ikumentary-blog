include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
  # Sign in without Capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else  
    visit admin_sign_in_path
    fill_in 'Login',    with: user.login
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end
end