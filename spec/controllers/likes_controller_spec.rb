require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  before do
    @user = create_user
    @secret = @user.secrets.create(content: "secret")
    @like = Like.create(user:@user, secret:@secret)
  end
  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access create" do
      post :create
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access destroy" do
      delete :destroy, id: @like
      expect(response).to redirect_to('/sessions/new')
    end
  end
  describe "when signed in as the wrong user" do
    before do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @wrong_user.id
    end
    it "cannot access destroy" do
      delete :destroy, id: @like, user_id: @user
      expect(response).to redirect_to("/secrets")
      log_in @wrong_user
      visit '/secrets'
      expect(page).to have_text(@secret.content)
      expect(page).to have_text('1 likes')
    end
  end 
end
