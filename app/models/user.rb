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

end
