class Student < ActiveRecord::Base
    attr_accessible :uin, :first_name, :last_name#, :adivsor, :degree, :start_semester, :gpa, :position,
                    #:course_taken, :course_taed, :preferred_area, :preferred_course, :status, :active_term
end
