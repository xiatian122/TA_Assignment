class SessionsController < ApplicationController
  #get 'login'
  def new
  end
  #post   'login'
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

  #delete 'logout'
  def destroy
  	log_out
  	redirect_to root_url
  end
end
