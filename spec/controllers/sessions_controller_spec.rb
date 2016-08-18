require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #login" do
    it "returns http redirect" do
      get :login
      expect(response).to have_http_status(:redirect)
    end
  end

end
