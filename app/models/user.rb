class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :uin, :email, :identity, :elpe, :login, :start_semester, :guaranteed, :active
	
	
	
    # (getter) Whole name for user: "first_name last_name" 
    def name
    return  self.first_name + " " + self.last_name
    end
    # (setter) Whole name for user: "first_name last_name" 
    def name=(value)
        @name_split = value.split(' ')
       self.first_name = @name_split[0]
       self.last_name = @name_split[1]
       #? self.save!
    end
    
    
    

end
