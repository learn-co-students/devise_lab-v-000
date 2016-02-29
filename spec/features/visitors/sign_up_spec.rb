# Feature: Sign up
#   As a visitor
#   I want to sign up
#   So I can visit protected areas of the site
feature 'Sign Up', :devise do

  # Scenario: Visitor can sign up with valid email address and password
  #   Given I am not signed in
  #   When I sign up with a valid email address and password
  #   Then I see a successful sign up message
  scenario 'visitor can sign up with valid email address and password' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'please123'
    fill_in 'user_password_confirmation', with: 'please123'
    within('.new_user') do
      click_button 'Sign up'
    end
    txts = [I18n.t( 'devise.registrations.signed_up'), I18n.t( 'devise.registrations.signed_up_but_unconfirmed')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  # Scenario: Visitor cannot sign up with invalid email address
  #   Given I am not signed in
  #   When I sign up with an invalid email address
  #   Then I see an invalid email message
  scenario 'visitor cannot sign up with invalid email address' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'bogus'
    fill_in 'user_password', with: 'please123'
    fill_in 'user_password_confirmation', with: 'please123'
    within('.new_user') do
      click_button 'Sign up'
    end
    expect(page).to have_content 'Email is invalid'
  end

  # Scenario: Visitor cannot sign up without password
  #   Given I am not signed in
  #   When I sign up without a password
  #   Then I see a missing password message
  scenario 'visitor cannot sign up without password' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: ' '
    fill_in 'user_password_confirmation', with: ' '
    within('.new_user') do
      click_button 'Sign up'
    end
    expect(page).to have_content "Password can't be blank"
  end

  # Scenario: Visitor cannot sign up with a short password
  #   Given I am not signed in
  #   When I sign up with a short password
  #   Then I see a 'too short password' message
  scenario 'visitor cannot sign up with a short password' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'please'
    fill_in 'user_password_confirmation', with: 'please'
    within('.new_user') do
      click_button 'Sign up'
    end
    expect(page).to have_content "Password is too short"
  end

  # Scenario: Visitor cannot sign up without password confirmation
  #   Given I am not signed in
  #   When I sign up without a password confirmation
  #   Then I see a missing password confirmation message
  scenario 'visitor cannot sign up without password confirmation' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'please123'
    fill_in 'user_password_confirmation', with: ''
    within('.new_user') do
      click_button 'Sign up'
    end
    expect(page).to have_content "Password confirmation doesn't match"
  end

  # Scenario: Visitor cannot sign up with mismatched password and confirmation
  #   Given I am not signed in
  #   When I sign up with a mismatched password confirmation
  #   Then I should see a mismatched password message
  scenario 'visitor cannot sign up with mismatched password and confirmation' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'please123'
    fill_in 'user_password_confirmation', with: 'mismatch'
    within('.new_user') do
      click_button 'Sign up'
    end
    expect(page).to have_content "Password confirmation doesn't match"
  end

end
