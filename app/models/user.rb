class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :uin, :email, :identity, :elpe, :login, :start_semester, :guaranteed, :active, :password, :password_confirmation

	#attr_accessible :name
	
  has_secure_password
	
    # (getter) Whole name for user: "first_name last_name" 
    def name
        if self.nil? || self.first_name.nil? || self.last_name.nil?
            return nil
        end
       else return  self.first_name + " " + self.last_name
    end
    # (setter) Whole name for user: "first_name last_name" 
    def name=(value)
        @name_split = value.split(' ')
       self.first_name = @name_split[0]
       self.last_name = @name_split[1]
       #? self.save!
    end
    
    def admin?
      return self.identity == "ADMIN"
    end
    
    def student?
      return self.identity == "PHD" || self.identity == "MS" || self.identity == "MENG"
    end

    def faculty?
      return self.identity == "FACULTY"
    end

end
