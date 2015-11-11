class CoursesController < ApplicationController
  include CoursesHelper
  before_filter :check_for_cancel, :only => [:create, :update]

	def index
    @courses = Course.all
    @courses_ta = Hash.new 
    internal_courses_ta = Hash.new  # internal usage

    @ta_status = Hash.new
    
    @courses.each do |course|
      tadata_matching = AppCourseMatching.where(course_id: course.id)
      tadata_ids = Array.new
      tadata_status = Hash.new 
      tadata_matching.each do |matching|
        tadata_ids << matching.student_application_id
        tadata_status[matching.student_application_id] = {'status' => matching.status, 'position' => matching.position}
      end
      tadata = StudentApplication.where("id = ?", tadata_ids)  # This will return one list
      @courses_ta[course.id] = tadata
      @ta_status[course.id] = tadata_status

      internal_courses_ta[course.id] = []
      tadata.each_index do |i|
        internal_courses_ta[course.id][i] = tadata[i].attributes
      end

      
    end
    @SlotStatus = getSlotStatusForAllCourses(internal_courses_ta)
    #debugger
  end

  #  /courses/new
  def new
  # default: render 'new' template
    @course = Course.new
  end


  # POSt /courses
  def create
    @course = Course.create!(params[:course])
    #debugger
    flash[:notice] = "#{@course.name} was successfully created."
    redirect_to courses_path
    end

  # GET /courses/:id
  def show
    @course = Course.find(params[:id])
  end
  
  # GET /courses/:id/edit
  def edit
    @course = Course.find params[:id]
  end
  

  # PATCH /courses/:id
  def update
    @course = Course.find params[:id]
    @course.update_attributes!(params[:course])
    flash[:notice] = "#{@course.name} was successfully updated."
    redirect_to courses_path
  end

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to courses_path
    end
  end

  # DELETE /courses/:id
  def destroy
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html {redirect_to courses_url, notice: "Course #{@course.name} was successfully destroyed"}
      format.json {head :no_content}
    end
  end

  def select_new_ta
    @course = Course.find(params[:id])

    @student_application_info = Hash.new
    @student_application_requesters = Hash.new 

    @studentapplications = StudentApplication.where(application_pool_id: @course.application_pool_id)

    @studentapplications.each do |studentapplication|
      @app_course_matching = AppCourseMatching.where(student_application_id: studentapplication.id)
      info_for_student = Hash.new 
      assignable = true

      #Retrieve status info for each assigned course
      if @app_course_matching.length > 0
        matching_for_student = Array.new
        #if already two half TA, cannot assign
        if @app_course_matching.length == 2
          assignable = false
        elsif @app_course_matching[0].position == AppCourseMatching::FULLTA
          assignable = false
        end

        @app_course_matching.each do |app_matching|
          matched_course = Course.find app_matching.course_id 
          matching_for_student <<{'Course' => matched_course.name, 'Position' => app_matching.position, 'app_status' =>app_matching.status } 
        end
        info_for_student['status'] = matching_for_student
      end
      info_for_student['assignable'] = assignable

      #Retrieve requester info
      requesters = studentapplication.requester
      if requesters
        requester_for_student = Array.new 
        split_requester = requesters.split(',')
        split_requester.each do |requested_course|
          r_course = Course.find requested_course
          requester_for_student << {'Course' => r_course.name, 'Lecturer' => r_course.lecturer}
        end
        info_for_student['requesters'] = requester_for_student
      end
      @student_application_info[studentapplication.id] = info_for_student
    end
  end

  def assign_new_ta
    id = params[:id]
    @course = Course.find(id)
    if params[:ids]
      new_tas = params[:ids].keys
      positions = params[:positions]
      if not new_tas.empty?
        new_tas.each do |ta_id|
          position = positions[ta_id]
          if position
            @new_matching = AppCourseMatching.new
            @new_matching.student_application_id = ta_id
            @new_matching.course_id = id 
            @new_matching.application_pool_id = @course.application_pool_id
            @new_matching.status = StudentApplication::TEMP_ASSIGNED
            @new_matching.position = position
            @new_matching.save

            @studentapplication = StudentApplication.find(ta_id)
            # @studentapplication.course_assigned = @course.id
            # @studentapplication.status = StudentApplication::TEMP_ASSIGNED
            # @studentapplication.save!
          end
        end
      end
    end
    flash[:notice] = "New TA assigned for #{@course.name}"
    redirect_to courses_path
  end

  # Email  
  def email_ta_notification
    @matching = AppCourseMatching.where("student_application_id = ? and course_id = ?", params[:ta_id], params[:id]).first
    @matching.status = StudentApplication::EMAIL_NOTIFIED
    @matching.save!

    @studentapplication = StudentApplication.find(params[:ta_id])
    # @studentapplication.status = StudentApplication::EMAIL_NOTIFIED
    # @studentapplication.save!

    @user = User.find_by(:uin => @studentapplication.uin)
    ## Sent mail to @user
    UserNotifier.send_ta_notification(@user).deliver_now
    flash[:notice] = "A Notification Email has been sent to #{@studentapplication.fullName()}: #{@user.email}"
    redirect_to courses_path
  end

  # Confirm courses/confirm_ta/:id/:ta_id
  def confirm_ta
    @matching = AppCourseMatching.where("student_application_id = ? and course_id = ?", params[:ta_id], params[:id]).first
    @matching.status = StudentApplication::ASSIGNED
    @matching.save!

    @studentapplication = StudentApplication.find(params[:ta_id])
    # @studentapplication.status = StudentApplication::ASSIGNED
    # @studentapplication.save!

    flash[:notice] = "TA #{@studentapplication.fullName()} is confirmd!"
    redirect_to courses_path
  end

  # Delete courses/delete_ta
  def delete_ta
    @course = Course.find params[:id]
    @matching = AppCourseMatching.where("student_application_id = ? and course_id = ?", params[:ta_id], params[:id]).first
    @matching.destroy

    @studentapplication = StudentApplication.find(params[:ta_id])
    # @studentapplication.status = StudentApplication::UNDER_REVIEW
    # @studentapplication.course_assigned = 0
    # @studentapplication.save!

    flash[:notice] = "TA #{@studentapplication.fullName()} is deleted for #{@course.name}"
    redirect_to courses_path
  end
end
