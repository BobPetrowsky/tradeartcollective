require 'rails_helper'

feature 'authenticated user may sign in', %Q(

  As an unauthenticated user
  I want to sign in
  So that I can post items

) do

  scenario 'user signs in' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign in'

    expect(page).to have_content("Facebook")
  end

end

