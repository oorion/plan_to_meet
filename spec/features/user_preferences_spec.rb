require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "User Preferences", :type => :feature do
  it "allows user to see preferences link" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    expect(page).to have_content("Preferences")
  end

  it "allows a user to input their preferences" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_link_or_button("Preferences")

    expect(page).to have_content("Email")
    expect(page).to have_content("Phone Number")
  end
end
