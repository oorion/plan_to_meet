require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "User Preferences", :type => :feature do
  it "allows user to see preferences link" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    expect(page).to have_content("Preferences")
  end

  it "allows a user to input their preferences and update their status" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(User).to receive(:recommend_events).and_return([])
    allow_any_instance_of(User).to receive(:store_past_events).and_return([])
    visit root_path
    click_link_or_button("Preferences")

    fill_in "user[email]", with: "test@example.com"
    fill_in "user[phone_number]", with: "123-456-7890"
    click_link_or_button("Update Contact Information")

    expect(User.last.email).to eq("test@example.com")
    expect(User.last.phone_number).to eq("123-456-7890")
    expect(current_path).to eq(user_path(id: user.id))
    expect(page).to have_content("Your contact information was updated")
  end
end
