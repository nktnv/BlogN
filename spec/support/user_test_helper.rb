module UserTestHelper

  def header_menu
    find(:xpath, '//*[contains(@class,"navbar-nav")]')
  end

  def sign_up(first_name, last_name, email, password)
    visit root_path
    header_menu.find(:xpath, './/*[text()="Sign up"]').click
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    click_button 'Create User'
  end

  def login(email, password)
    visit root_path
    header_menu.find(:xpath, './/*[text()="Log in"]').click
    fill_in 'session[email]', with: email
    fill_in 'session[password]', with: password
    click_button 'Log in'
  end

  def logout
    visit root_path
    find(:xpath, '//*[contains(@class,"navbar-nav")]//*[text()="Log out"]').click
  end

  def encrypted_password(password)
    BCrypt::Password.create(password)
  end

  def get_new_user
    get '/signup'
  end

  def get_log_in
    get '/login'
  end

  def get_root_path
    get '/'
  end

end
