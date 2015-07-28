require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit '/users/new'
    expect(page).to have_content "Sign Up"
  end


  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      sign_up_as_butcher
      visit "/"
      expect(page).to have_content "butcher"
    end
  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    sign_up_as_butcher
    click_on "Sign Out"
    sign_in_as_butcher
    expect(page).to have_content "butcher"
  end
end

feature "logging out" do

  scenario "begins with logged out state" do
    visit '/users'

    expect(page).not_to have_content "butcher"
  end

  scenario "doesn't show username on the homepage after logout" do
    sign_up_as_butcher
    click_on "Sign Out"
    visit "/"

    expect(page).not_to have_content "butcher"
  end
end
