class Course < ActiveRecord::Base
	attr_accessible :cid, :section, :name, :credits, :lecturer_uin, :area, :notes, :description, :ta, :notes, :application_pool_id, :suggestion

    

    # Lecture name (getter)
    def lecturer
        @current_user = User.find_by(uin: self.lecturer_uin)
        
        ## Check the user exists
        if @current_user.nil?
           return "N/A" 
        else
            return @current_user.first_name + " " + @current_user.last_name
        end
    end

    
    # Instructor's email (getter)
    def insemail
        @lecturer_user = User.find_by(uin: self.lecturer_uin)
        
        ## Check the user exists
        if @lecturer_user.nil?
            return "N/A"
        else
            return @lecturer_user.email
        end
    end
    

end
