class SessionsController < ApplicationController
  #get 'login'
  def new
  end
  #post   'login'
  def create
  	user = User.find_by(uin: params[:session][:uin])
  	if !user.nil? && user.authenticate(params[:session][:password]) 
  		log_in user
      redirect_to user
  	else
  		flash.now[:danger]="Invalid UIN or Password!"
			render 'new'
		end
  end
  
  # Get /passwd
  def passwd
  end
  
  # Generate a random password and pass to the user
  def reset_passwd
    @user = User.find_by(uin: params[:session][:uin])
    if !@user.nil? && @user.first_name.downcase ==  params[:session][:first_name].to_s.downcase
      UserNotifier.send_login_password(@user, SecureRandom.hex(10)).deliver_now
      flash[:success] = "Password has been sent to your email address!"
      redirect_to login_path
    else
      flash[:danger]="Invalid User: Wrong UIN Name Match!"
      redirect_to login_path
    end
  end

  #delete 'logout'
  def destroy
  	log_out
  	redirect_to root_url
  end
end
