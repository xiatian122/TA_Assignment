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
end
