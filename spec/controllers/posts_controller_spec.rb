require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "posts#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "posts#create action" do
    it "should successfully create a new post in the db" do
      post :create, post: {title: 'Hello', body: 'New post!'}
      expect(response).to redirect_to root_path

      post = Post.last
      expect(post.body).to eq('New post!')
      expect(post.title).to eq('Hello')
    end

    context "should properly deal with validation errors" do
      it "has a title, but empty body" do
        post :create, post: { title: 'No comment', body: '' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Post.count).to eq 0
      end

      it "has no title, but it does have a body" do
        post :create, post: { title: '', body: 'No good...' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Post.count).to eq 0
      end
    end
  end
end
