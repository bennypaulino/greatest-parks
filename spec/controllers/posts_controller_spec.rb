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
  end
end
