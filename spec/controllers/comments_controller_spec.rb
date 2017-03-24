require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do
    it "should allow users to create comments on posts" do
      agreeable_post = FactoryGirl.create(:post)

      user = FactoryGirl.create(:user)
      sign_in user

      post :create, post_id: agreeable_post.id, comment: { comment_body: 'I totally agree' }

      expect(response).to redirect_to post_path(agreeable_post)
      expect(agreeable_post.comments.length).to eq 1
      expect(agreeable_post.comments.first.comment_body).to eq "I totally agree"
    end

    it "should require a user to be logged in to comment" do
      sorry_post = FactoryGirl.create(:post)

      post :create, post_id: sorry_post.id, comment: { comment_body: 'No way...' }
      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code of not found if the post isn't found" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, post_id: 'FAKEID', comment: { comment_body: 'Just fishing...' }
      expect(response).to have_http_status :not_found
    end
  end
end
