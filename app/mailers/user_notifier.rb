class UserNotifier < ApplicationMailer
	default :from => 'bazingaagile@gmail.com'

	# send a nofigication email to TA candidates
	def send_ta_notification(user)
		@user = user
		mail( :to => @user.email, :subject => 'You have just been assigned to a course!')
	end
end
