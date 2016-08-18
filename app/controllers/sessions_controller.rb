class SessionsController < ApplicationController
  def new
  end

  def login
  	user = User.find_by(email:params[:email])
  	flash[:errors] = []
  	if params[:email] == ''
  		flash[:errors] << "Email cannot be blank"
  	end
  	if params[:password] == ''
  		flash[:errors] << "Password cannot be blank"
  	end
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to "/users/#{ user.id }"
  	else
  		flash[:errors] << "Invalid Login"
  		redirect_to "/sessions/new"
  	end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to "/sessions/new"
  end
end
