class StudentsController < ApplicationController
    def index
        @students = Student.all
    end
    
    def new
    # default: render 'new' template
    end
    
    def create
        @student = Student.create!(params[:student])
        #debugger
        flash[:notice] = "#{@student.uin} was successfully created."
        redirect_to students_path
    end
    
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
    
    def edit
        @student = Student.find params[:id]
    end
    
    def update
       @student = Student.find params[:id]
       @withdraw = params[:active_term]
       
       if @withdraw.nil?
           @student.update_attributes!(params[:student])
           flash[:notice] = "#{@student.first_name} was successfully updated."
           redirect_to student_path(@student)
        else
            @student.active_term = '0'
            flash[:notice] = "#{@student.first_name}\'s Application was withdrawed."
            redirect_to student_path(@student)
        end
    end
    
    def withdraw_application
       @student = Student.find params[:id]
       @student.active_term = '0'
       @student.save!
       flash[:notice] = "#{@student.first_name}\'s Application was withdrawed."
       redirect_to student_path(@student)
    end
end
