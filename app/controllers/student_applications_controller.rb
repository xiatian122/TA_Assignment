class StudentApplicationsController < ApplicationController
     #  /studentapplications
  def index
    @studentapplications = StudentApplication.all
  end
  
  #  /studentapplications/new
  def new
  # default: render 'new' template
    @studentapplication = Student.new
  end

  # POSt /studentapplications
  def create
    @studentapplication = StudentApplication.create!(params[:studentapplication])
    #TODO, modify this part code, so it automatically gives correct active_term literal
    @studentapplication.active_term = "20153"
    @studentapplication.status = Student::UNDER_REVIEW
    @studentapplication.save
    #debugger
    flash[:notice] = "#{@studentapplication.uin} was successfully created."
    redirect_to studentapplications_path
  end

  # GET /studentapplications/:id
  def show
    id = params[:id]
    @studentapplication = StudentApplication.find(id)
    if @studentapplication.status == StudentApplication::EMAIL_NOTIFIED
      @course = Course.find(@studentapplication.course_assigned)
    end
  end
  
  # GET /studentapplications/:id/edit
  def edit
    @studentapplication = StudentApplication.find params[:id]
  end
  

  # PATCH /studentapplications/:id
  def update
    @studentapplication = StudentApplication.find params[:id]
    @studentapplication.update_attributes!(params[:studentapplication])
    flash[:notice] = "#{@studentapplication.first_name} was successfully updated."
    redirect_to studentapplication_path(@studentapplication)
  end
  
  # GET /studentapplications/(:id)/withdraw_application
  def withdraw_application
   @studentapplication = StudentApplication.find params[:id]
   @studentapplication.active_term = '0'
   @studentapplication.save!
   flash[:notice] = "#{@studentapplication.first_name}\'s Application was withdrawed."
   redirect_to studentapplication_path(@studentapplication)
  end

  def accept_assignment
    @studentapplication = StudentApplication.find params[:id]
    @studentapplication.status = StudentApplication::STUDENT_CONFIRMED
    @studentapplication.save!
    flash[:notice] = "Accepted TA Position!"
    redirect_to studentapplication_path(@studentapplication)
  end

  def reject_assignment
    @studentapplication = StudentApplication.find params[:id]
    @studentapplication.status = StudentApplication::STUDENT_REJECTED
    @studentapplication.save!
    flash[:notice] = "Rejected TA Position!"
    redirect_to studentapplication_path(@studentapplication)
  end
end
