class Student < ActiveRecord::Base
  attr_accessible :uin, :first_name, :last_name, :advisor, :degree, :start_semester, :gpa, :position,
                  :course_taken, :course_taed, :preferred_area, :preferred_course, :status, :active_term

  def fullName()
    return  self.first_name + " " + self.last_name
  end
end
