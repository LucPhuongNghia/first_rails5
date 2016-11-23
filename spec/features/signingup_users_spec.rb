require "rails_helper"

RSpec.feature "User signup" do
  scenario "User signup with valid credentials" do
    visit "/"
    click_link "Sign Up"
    
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    
    expect(page).to have_content("You have signed up successfully")
  end
  
  scenario "User signup with invalid credentails" do
    visit "/"
    click_link "Sign Up"
    
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
  end
end