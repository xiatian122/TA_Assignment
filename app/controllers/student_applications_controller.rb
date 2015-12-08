class StudentApplicationsController < ApplicationController
     #  /student_applications
  load_and_authorize_resource

  def index
    @studentapplications = StudentApplication.all
    @student_application_info = Hash.new
    @studentapplications.each do |student_application|
      @status_for_student = Array.new
      @matching = AppCourseMatching.where(student_application_id: student_application.id)
      if @matching.length > 0
        @matching.each do |m|
          course = Course.find m.course_id 
          @status_for_student << {'Course' => course.name, 'Position' => m.position, 'Status' => m.status}
        end
      end
      @student_application_info[student_application.id] = @status_for_student
    end
  end
  
end
