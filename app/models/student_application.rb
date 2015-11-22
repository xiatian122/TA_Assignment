class StudentApplication < ActiveRecord::Base
  attr_accessible :advisor, :gpa, :position, :requester,
                  :course_taken, :course_taed, :preferred_area, :preferred_course, :status, :active_term, :course_assigned, :application_pool_id, :user_id
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
  FACULTY = 5



  # (Getter) Compose applicant's full name
  def fullName()
    return  self.first_name + " " + self.last_name
  end
  
  
  # (Getter) Get applicant's uin
  def uin
    
  end
  
  
  # (Getter) Get applicant's first name
  def first_name
    
  end
  
  
  # (Getter) Get applicant's last name
  def last_name
    
  end
  
  # (Getter) Get applicant's degree
  def degree
    
    
  end
  
  
  # (Getter) Get applicant's start_semester
  def start_semester
    
  end
  
  
  # (Getter) Get 
  
end