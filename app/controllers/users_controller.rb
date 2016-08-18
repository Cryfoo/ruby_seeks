class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def new
  end
  def show
  	set_user
  	@secrets = Secret.where(user:@user)
  	@liked = @user.secrets_liked
  end
  def create
  	user = User.create(user_params)
  	if user.valid?
  		session[:user_id] = user.id
	  	redirect_to "/users/#{ user.id }"
	else
		flash[:errors] = user.errors.full_messages
		redirect_to "/users/new"
	end
  end
  def edit
  	set_user
  end
  def update
  	set_user
  	@user.update(email:params[:email], name:params[:name])
  	if @user.valid?
  		redirect_to "/users/#{ @user.id }"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to "/users/#{ @user.id }/edit"
  	end
  end
  def destroy
  	set_user
  	@user.destroy
  	session[:user_id] = nil
  	redirect_to "/sessions/new"
  end

  private
  def user_params
  	params.permit(:name, :email, :password, :password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
