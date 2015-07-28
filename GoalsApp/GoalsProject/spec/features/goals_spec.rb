require 'rails_helper'


feature "Creating goals" do

  scenario "signing in or signing up takes user to user show page" do
    sign_up_as_butcher
    expect(current_path).to match(/^\/users\/(\d)+/)

    click_on 'Sign Out'
    sign_in_as_butcher
    expect(current_path).to match(/^\/users\/(\d)+/)
  end

  scenario "Button to create goal on user show page" do
    sign_up_as_butcher
    expect(page).to have_content "Create goal"
  end

  scenario "Doesn't display private goals to anyone but the user" do
    sign_up_as_butcher
    fill_in 'Create A Goal', :with => "test_goal"
    check("Private")
    click_on "Create goal"
    click_on "Sign Out"

    expect(page).not_to have_content "test_goal"
  end

  scenario "Adds goal to incomplete goals list" do
    sign_up_as_butcher
    fill_in 'Create A Goal', :with => "test_goal"
    click_on "Create goal"
    expect(page).to have_content "test_goal"
  end

end

feature "Completing goals" do

  scenario "has button to complete goals" do
    sign_up_as_butcher
    fill_in 'Create A Goal', :with => "test_goal"
    click_on "Create goal"

    expect(page).to have_content "Mark as Complete"
  end

  scenario "Marking goal as complete should move goal to completed goals" do
    sign_up_as_butcher
    fill_in 'Create A Goal', :with => "test_goal"
    click_on "Create goal"
    click_on "Mark as Complete"

    expect(page).to have_content "Completed Goals test_goal"
  end
end
