class UserNotifier < ApplicationMailer
	default :from => 'bazingaagile@gmail.com'

	# send a nofigication email to TA candidates
	def send_ta_notification(user, msg)
		@user = user
		@msg = msg
		mail( :to => @user.email, :subject => 'You have just been assigned to a course!')
	end
	
	# send dynamic login password to 
	def send_login_password(user, passwd)
		@user = user
		@user.password = passwd #SecureRandom.hex(10)
		@user.save!
		mail( :to => @user.email, subject: "Welcome to CSE TA Assignment System! Your initial password!")
	end
end
