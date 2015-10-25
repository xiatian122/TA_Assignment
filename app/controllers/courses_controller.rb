class CoursesController < ApplicationController

  before_filter :check_for_cancel, :only => [:create, :update]

	def index
    @courses = Course.all
  end

  #  /courses/new
  def new
  # default: render 'new' template
    @course = Course.new
  end


  # POSt /courses
  def create
    @course = Course.create!(params[:student])
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
end
