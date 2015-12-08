class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :uin, :email, :identity, :elpe, :start_semester, :guaranteed, :active, :password, :password_confirmation

	#attr_accessible :name
	
  has_secure_password
	
    # (getter) Whole name for user: "first_name last_name" 
    def name
        if self.nil? || self.first_name.nil? || self.last_name.nil?
            return nil
        else return  self.first_name + " " + self.last_name
        end
    end
    # (setter) Whole name for user: "first_name last_name" 
    def name=(value)
       @name_split = value.split(' ')
       self.first_name = @name_split[0]
       self.last_name = @name_split[1]
    end
    
    def admin?
      return self.identity.to_s == "ADMIN"
    end
    
    def student?
      return self.identity.to_s == "PHD" || self.identity.to_s == "MS" || self.identity.to_s == "MENG"
    end

    def faculty?
      return self.identity.to_s == "FACULTY"
    end

    def destroy
      #delete related student applications, courses
      @related_courses = Course.where(lecturer_uin: self.uin)
      @related_courses.destroy_all

      @related_student_applications = StudentApplication.where(user_id: self.id)
      @related_student_applications.destroy_all

      super
    end

    def self.guaranteeForTA?(id)
      if not id
        return "N/A1"
      else
        @user = User.find_by id
        if @user
          return @user.guaranteed?
        else
          return "N/A2"
        end
      end
    end

end
