class CoursesController < ApplicationController
  include CoursesHelper
  before_filter :check_for_cancel, :only => [:create, :update]

	def index
    @courses = Course.all
    @courses_ta = Hash.new 
    internal_courses_ta = Hash.new  # internal usage
    
    @courses.each do |course|
      tadata = StudentApplication.where(:course_assigned => course.id)  # This will return one list
      @courses_ta[course.id] = tadata

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
    @student_application_status = Hash.new
    @student_application_assignable = Hash.new
    @student_application_requesters = Hash.new 
    @studentapplications = StudentApplication.where(application_pool_id: @course.application_pool_id)
    @studentapplications.each do |studentapplication|
      @app_course_matching = AppCourseMatching.find_by(student_application_id: studentapplication.id)
      @assignable = true
      if not @app_course_matching
        @app_course_matching.each do |app_matching|
          if app_matching.status == AppCourseMatching.LECTURER_REQUEST
            @requested_course = Course.find(app_matching.course_id)
            student_application_requesters << @requested_course.lecturer
          else
            @student_application_status[studentapplication.id] << app_matching.status
            if app_matching.status != AppCourseMatching >= 2
              @assignable = false 
            end
          end
        end
      end
      @student_application_assignable[studentapplication.id] = @assignable
    end
  end

  def assign_new_ta
    id = params[:id]
    @course = Course.find(id)
    if params[:ids]
      new_tas = params[:ids].keys
      if not new_tas.empty?
        new_tas.each do |ta_id|
          @studentapplication = StudentApplication.find(ta_id)
          @studentapplication.course_assigned = @course.id
          @studentapplication.status = StudentApplication::TEMP_ASSIGNED
          @studentapplication.save!
        end
      end
    end
    flash[:notice] = "New TA assigned for #{@course.name}"
    redirect_to courses_path
  end

  # Email  
  def email_ta_notification
    @studentapplication = StudentApplication.find(params[:ta_id])
    @studentapplication.status = StudentApplication::EMAIL_NOTIFIED
    @studentapplication.save!
    @user = User.find_by(:uin => @studentapplication.uin)
    ## Sent mail to @user
    UserNotifier.send_ta_notification(@user).deliver_now
    flash[:notice] = "A Notification Email has been sent to #{@studentapplication.fullName()}: #{@user.email}"
    redirect_to courses_path
  end

  # Confirm courses/confirm_ta/:id/:ta_id
  def confirm_ta
    @studentapplication = StudentApplication.find(params[:ta_id])
    @studentapplication.status = StudentApplication::ASSIGNED
    @studentapplication.save!
    flash[:notice] = "TA #{@studentapplication.fullName()} is confirmd!"
    redirect_to courses_path
  end

  # Delete courses/delete_ta
  def delete_ta
    @course = Course.find(params[:id])
    @studentapplication = StudentApplication.find(params[:ta_id])
    @studentapplication.status = StudentApplication::UNDER_REVIEW
    @studentapplication.course_assigned = 0
    @studentapplication.save!

    flash[:notice] = "TA #{@studentapplication.fullName()} is deleted for #{@course.name}"
    redirect_to courses_path
  end
end
