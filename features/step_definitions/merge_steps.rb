# Add a declarative step here for populating the DB with movies.
And /^I am a nonadmin user$/ do
  User.create!({:login => 'nonadmin',
                :password => 'nonadminpwd',
                :email => 'azhicodan@gmail.com',
                :profile_id => 2,
                :name => 'nonadmin',
                :state => 'active'})
  visit '/accounts/login'
  fill_in 'user_login', :with => 'nonadmin'
  fill_in 'user_password', :with => 'nonadminpwd'
  click_button 'Login'
end

Then /^I should not be able to merge articles$/ do
  assert page.has_no_content?("merge_with")
end





