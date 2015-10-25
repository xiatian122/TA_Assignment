class StudentsController < ApplicationController
  #  /students
  def index
    @students = Student.all
  end
  
  #  /students/new
  def new
  # default: render 'new' template
    @student = Student.new
  end

  # POSt /students
  def create
    @student = Student.create!(params[:student])
    #TODO, modify this part code, so it automatically gives correct active_term literal
    @student.active_term = "20153"
    @student.save
    #debugger
    flash[:notice] = "#{@student.uin} was successfully created."
    redirect_to students_path
    end

  # GET /students/:id
  def show
    id = params[:id]
    @student = Student.find(id)
    @student_status = @student.status
    if @student_status == 1
      @status = 'Under review'
    elsif @student_status == 2
      @status = 'Assigned'
    elsif @student_status == 3
      @status = 'Confirmed'
    else
      @status = 'Accepted'
    end
  end
  
  # GET /students/:id/edit
  def edit
    @student = Student.find params[:id]
  end
  

  # PATCH /students/:id
  def update
    @student = Student.find params[:id]
    @student.update_attributes!(params[:student])
    flash[:notice] = "#{@student.first_name} was successfully updated."
    redirect_to student_path(@student)
  end
  
  # GET /students/(:id)/withdraw_application
  def withdraw_application
   @student = Student.find params[:id]
   @student.active_term = '0'
   @student.save!
   flash[:notice] = "#{@student.first_name}\'s Application was withdrawed."
   redirect_to student_path(@student)
  end
 end
