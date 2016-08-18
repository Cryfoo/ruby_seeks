class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  def index
  	@secrets = Secret.all
  end
  def create
  	user = User.find(session[:user_id])
  	secret = Secret.create(content:params[:secret], user:user)
  	redirect_to "/users/#{ user.id }"
  end
  def destroy
  	secret = Secret.find(params[:id])
  	user = current_user
  	secret.destroy if secret.user == user
  	redirect_to "/users/#{ user.id }"
  end
end
