module CoursesHelper

  def getSlotStatusForAllCourses( courses_ta_hash)
    courses = Course.all
    to_be_returned_hash = Hash.new()
    # initializing
    courses.each do |course|
      to_be_returned_hash[course.id] = {assigned: 0, slots:0}
    end
    # populating
    courses_ta_hash.each do |course_id, ta_array|
      to_be_returned_hash[course_id][:slots] = ta_array.length()
      ta_array.each do |ta_hash|
        if ta_hash["status"] == 6
          to_be_returned_hash[course_id][:assigned] = to_be_returned_hash[course_id][:assigned]  + 1
        end
      end
    end

    return to_be_returned_hash
  end
end
