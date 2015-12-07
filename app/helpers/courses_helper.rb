module CoursesHelper

  def getSlotStatusForAllCourses( ta_status)
    courses = Course.all
    to_be_returned_hash = Hash.new()
    # initializing
    courses.each do |course|
      to_be_returned_hash[course.id] = {assigned: 0, slots:0}
    end
    # populating
    ta_status.each_pair do |course_id, ta_hash|
      to_be_returned_hash[course_id][:slots] = ta_hash.size()
      ta_hash.each_pair do |ta_id, single_ta_status_hash|
        # byebug
        if (single_ta_status_hash["status"] >= 4)
          to_be_returned_hash[course_id][:assigned] = to_be_returned_hash[course_id][:assigned]  + 1
        end
      end
    end

    return to_be_returned_hash
  end

  def getSemesterAndYear( headers)
    # Rack::Utils.parse_nested_query
    referer_url = headers["HTTP_REFERER"]
    # byebug
    query = ""
    if (/courses\?(.+)#?/.match(referer_url) != nil)
      query = /courses\?(.+)#?/.match(referer_url)[1]
    end
    
    query = Rack::Utils.parse_nested_query(query)
    return query
  end

end
