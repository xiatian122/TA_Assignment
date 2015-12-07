class ApplicationPool < ActiveRecord::Base
    attr_accessible :year, :semester, :deadline, :active

    def self.getAppPoolYearSemester(id)
	   	
	   	if not id
	   		return "All"
	   	else
	   		@application_pool = ApplicationPool.find(id)
			return "#{@application_pool.year} #{@application_pool.semester}"
		end
    end

    def canApply
    	return DateTime.now.utc < self.deadline.utc
    end

    def self.isActive(id)
    	if not id
    		return false
    	else
            @application_pool = ApplicationPool.find(id)
    		return @application_pool.active
    	end
    end

    # Destroy method for a application pool: Destroy related course, student application, matching as well
    def destroy
        # destroy related matchings
        
        @related_matchings = AppCourseMatching.where(application_pool_id: self.id)
        @related_matchings.destroy_all

        @related_courses = Course.where(application_pool_id: self.id)
        @related_courses.destroy_all

        @related_student_applications = StudentApplication.where(application_pool_id: self.id)
        @related_student_applications.destroy_all
       
        #destroy itself
        super
    end
end
