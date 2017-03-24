require 'rails_helper'

RSpec.feature 'Post comments', :type => feature do
  scenario "User adds a comment to a post" do
    given_there_is_a_post
  end

  def given_there_is_a_post
    @post = FactoryGirl.create(:post)
  end
end
