class AppCourseMatching < ActiveRecord::Base
	attr_accessible :application_pool_id, :student_application_id, :course_id, :position, :status
	
  # TEMP_ASSIGNED = 1
  # EMAIL_NOTIFIED = 2
  # STUDENT_CONFIRMED = 3
  # STUDENT_REJECTED = 4
  # ASSIGNED = 5

  FULLTA = 1
  HALFTA = 2
  GRADER = 3

end
