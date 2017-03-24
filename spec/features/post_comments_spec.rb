require 'rails_helper'

RSpec.feature 'Post comments', type: :feature do
  scenario "User adds a comment to a post" do
    given_there_is_a_post
    and_i_am_logged_in_as_a_user
    when_i_visit_the_page_for_a_particular_post
    and_submit_a_comment_regarding_that_post
  end

  def given_there_is_a_post
    @post = FactoryGirl.create(:post)
  end

  def and_i_am_logged_in_as_a_user
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  def when_i_visit_the_page_for_a_particular_post
    visit post_path(@post)
  end

  def and_submit_a_comment_regarding_that_post
    smug_comment = FactoryGirl.create(:comment)

    fill_in 'Comment body', with: smug_comment
    click_on 'Add Comment'

    visit post_path(@post)
    expect(page).to have_content(smug_comment)
  end
end
