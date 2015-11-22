class StudentApplication < ActiveRecord::Base
  attr_accessible :advisor, :gpa, :requester,
                  :course_taken, :course_taed, :preferred_area, :preferred_course, :status, :application_pool_id, :user_id, :active_term
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
    
    @current_student = User.find(self.user_id)
    
    if @current_student.nil?
      return ""
    else
      return @current_student.name
    end
  end
  
  
  # (Getter) Get applicant's uin
  def uin
    
    @current_student = User.find_by(self.user_id)
    
    if @current_student.nil?
      return ""
    else
      return @current_student.uin
    end
  end
  
  
  # (Getter) Get applicant's first name
  def first_name
    
     @current_student = User.find(self.user_id)
    
    if @current_student.nil?
      return ""
    else
      return @current_student.first_name
    end
  end
  
  
  # (Getter) Get applicant's last name
  def last_name
    
     @current_student = User.find(self.user_id)
    
    if @current_student.nil?
      return ""
    else
      return @current_student.last_name
    end
  end
  
  # (Getter) Get applicant's degree
  def degree
    
    @current_student = User.find(self.user_id)
    
    if @current_student.nil?
      return ""
    else
      return @current_student.identity
    end
  end
  
  
  # (Getter) Get applicant's start_semester
  def start_semester
    
    @current_student = User.find(self.user_id)
    
    if @current_student.nil?
      return ""
    else
      return @current_student.start_semester
    end
  end
  
  
  # (Getter) 
  #def position
    
    
  #end
  
  
  #  :course_assigned,
  
end