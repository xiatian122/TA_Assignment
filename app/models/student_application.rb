class StudentApplication < ActiveRecord::Base
    attr_accessible :uin, :first_name, :last_name, :advisor, :degree, :start_semester, :gpa, :position,
                  :course_taken, :course_taed, :preferred_area, :preferred_course, :status, :active_term, :course_assigned
  UNDER_REVIEW = 1
  TEMP_ASSIGNED = 2
  EMAIL_NOTIFIED = 3
  STUDENT_CONFIRMED = 4
  STUDENT_REJECTED = 5
  ASSIGNED = 6

  UNDERGRAD = 1
  MENG = 2
  MS = 3
  PHD = 4

  def fullName()
    return  self.first_name + " " + self.last_name
  end
end
