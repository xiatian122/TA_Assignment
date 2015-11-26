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
  
  #  /studentapplications/new
  def new
  # default: render 'new' template
    # @studentapplication = StudentApplication.new
  end

  # POSt /student_applications
  def create
    @studentapplication = StudentApplication.create!(params[:student_application])
    #TODO, modify this part code, so it automatically gives correct active_term literal
    @studentapplication.active_term = "20153"
    @studentapplication.status = StudentApplication::UNDER_REVIEW
    @studentapplication.save
    puts params[:studentapplication]
    #debugger
    flash[:notice] = "#{@studentapplication.uin} was successfully created."
    redirect_to student_applications_path
  end

  # GET /student_applications/:id
  def show
    id = params[:id]
    @studentapplication = StudentApplication.find(id)
    if @studentapplication.status == StudentApplication::EMAIL_NOTIFIED
      @course = Course.find(@studentapplication.course_assigned)
    end
  end
  
  # GET /student_applications/:id/edit
  def edit
    @studentapplication = StudentApplication.find params[:id]
  end
  

  # PATCH /student_applications/:id
  def update
    @studentapplication = StudentApplication.find params[:id]
    @studentapplication.update_attributes!(params[:studentapplication])
    flash[:notice] = "#{@studentapplication.first_name} was successfully updated."
    redirect_to student_applications_path(@studentapplication)
  end
  
  # GET /student_applications/(:id)/withdraw_application
  def withdraw_application
   @studentapplication = StudentApplication.find params[:id]
   @studentapplication.active_term = '0'
   @studentapplication.save!
   flash[:notice] = "#{@studentapplication.first_name}\'s Application was withdrawed."
   redirect_to student_applications_path(@studentapplication)
  end

  def accept_assignment
    @studentapplication = StudentApplication.find params[:id]
    @studentapplication.status = StudentApplication::STUDENT_CONFIRMED
    @studentapplication.save!
    flash[:notice] = "Accepted TA Position!"
    redirect_to student_applications_path(@studentapplication)
  end

  def reject_assignment
    @studentapplication = StudentApplication.find params[:id]
    @studentapplication.status = StudentApplication::STUDENT_REJECTED
    @studentapplication.save!
    flash[:notice] = "Rejected TA Position!"
    redirect_to student_applications_path(@studentapplication)
  end
end
