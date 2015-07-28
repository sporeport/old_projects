require 'rails_helper'

feature "Users can comment on Users" do

  scenario "Has a comment on user button" do
    sign_up_as_butcher
    click_on "Sign Out"
    sign_up("florist")
    butcher = User.find_by(username: "butcher")
    visit "/users/#{butcher.id}"

    expect(page).to have_content "Comment on User"
  end

  scenario "Can leave a comment on user" do
    sign_up_as_butcher
    click_on "Sign Out"
    sign_up("florist")
    butcher = User.find_by(username: "butcher")
    visit "/users/#{butcher.id}"
    fill_in "Comment on User", :with => "a_comment"
    click_on "Comment User"

    expect(page).to have_content "a_comment"
  end

  scenario "Can not leave comments when not signed in" do
    sign_up_as_butcher
    click_on "Sign Out"
    butcher = User.find_by(username: "butcher")
    visit "/users/#{butcher.id}"

    expect(page).not_to have_content "Comment on User"
  end
end


feature "Users can comment on Goals" do

  scenario "Has a comment on goal button" do
    sign_up_as_butcher
    fill_in "Create A Goal", :with => "my_great_goal"
    click_on "Create goal"
    click_on "Sign Out"
    sign_up("florist")
    butcher = User.find_by(username: "butcher")
    visit "/users/#{butcher.id}"

    expect(page).to have_content "Comment on my_great_goal"
  end

  scenario "Can leave a comment" do
    sign_up_as_butcher
    fill_in "Create A Goal", :with => "my_great_goal"
    click_on "Create goal"
    click_on "Sign Out"
    sign_up("florist")
    butcher = User.find_by(username: "butcher")
    visit "/users/#{butcher.id}"
    fill_in "Comment on my_great_goal", :with => "a_comment"
    click_on "Comment Goal"

    expect(page).to have_content "a_comment"
  end

  scenario "Can not leave comments when not signed in" do
    sign_up_as_butcher
    fill_in "Create A Goal", :with => "my_great_goal"
    click_on "Create goal"
    click_on "Sign Out"

    expect(page).not_to have_content "Comment on Goal"
  end
end
