class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(uin: params[:session][:uin])
  	if user && user.authenticate(params[:session][:password])
  		log_in user
      redirect_to user
  	else
  		flash.now[:danger]="Invalid UIN or password!"
			render 'new'
		end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end
