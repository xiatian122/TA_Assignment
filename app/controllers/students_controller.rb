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
    end
    
    def edit
        @student = Student.find params[:id]
    end
end
