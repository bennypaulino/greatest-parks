require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "posts#show action" do
    it "should successfully show the page if the post is found" do

      post = FactoryGirl.create(:post)
      get :show, id: post.id
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the post isn't found" do
      get :show, id: 'monorailcat'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "posts#create action" do
    it "should require users to be logged in" do
      post :create, post: {title: 'OK', body: 'Keep it going'}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new post in the db" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, post: {title: 'Hello', body: 'New post!'}
      expect(response).to redirect_to root_path

      post = Post.last
      expect(post.body).to eq('New post!')
      expect(post.title).to eq('Hello')
      expect(post.user).to eq(user)
    end

    context "should properly deal with validation errors" do
      it "has a title, but empty body" do
        user = FactoryGirl.create(:user)
        sign_in user

        post_count = Post.count
        post :create, post: { title: 'No comment', body: '' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(post_count).to eq Post.count
      end

      it "has no title, but it does have a body" do
        user = FactoryGirl.create(:user)
        sign_in user

        post_count = Post.count
        post :create, post: { title: '', body: 'No good...' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(post_count).to eq Post.count
      end
    end
  end
end
