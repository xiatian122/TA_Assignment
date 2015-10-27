class CoursesController < ApplicationController

  before_filter :check_for_cancel, :only => [:create, :update]

	def index
    @courses = Course.all
    @courses_ta = Hash.new 
    @courses.each do |course|
      if not course.ta == 'N/A'
        talist = course.ta.split(';')
        tadata = Hash.new
        talist.each do |ta|
          student = Student.find(ta)
          tadata[ta] = [student.fullName(), student.status]
        end
      end
      @courses_ta[course.id] = tadata
    end
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
    @students = Student.where(status: 1)
  end

  def assign_new_ta
    id = params[:id]
    @course = Course.find(id)
    if params[:ids]
      new_tas = params[:ids].keys
      if not new_tas.empty?
        new_tas.each do |ta_id|
          @student = Student.find(ta_id)
          @student.status = 2
          @student.save!
          if @course.ta == 'N/A'
            @course.ta = ta_id.to_s
          else
            @course.ta = @course.ta + ';' + ta_id.to_s
          end
          @course.save!
        end
      end
    end
    flash[:notice] = "New TA assigned for #{@course.name}"
    redirect_to courses_path
  end

  # Email  
  def email_ta_notification
    @student = Student.find(params[:ta_id])
    @user = User.find_by(:uin => @student.uin)
    ## Sent mail to @user
    UserNotifier.send_ta_notification(@user).deliver
    flash[:notice] = "A Notification Email has been sent to #{@student.fullName()}: #{@user.email}"
    redirect_to courses_path
  end

  # Confirm courses/confirm_ta/:id/:ta_id
  def confirm_ta
    @student = Student.find(params[:ta_id])
    @student.status = 3
    @student.save!

    flash[:notice] = "TA #{@student.fullName()} is confirmd!"
    redirect_to courses_path
  end

  # Delete courses/delete_ta
  def delete_ta
    @course = Course.find(params[:id])
    @student = Student.find(params[:ta_id])
    @student.status = 1
    @student.save!

    ta_list = @course.ta.split(';')
    ta_list.delete(@student.id.to_s)
    if ta_list.empty?
      @course.ta = 'N/A'
    else
      @course.ta = ''  
      ta_list.each do |ta|
        if @course.ta = ''
          @course.ta = ta.to_s
        else
          @course.ta = @course.ta + ';' + ta.to_s
        end
      end
    end
    @course.save!

    flash[:notice] = "TA #{@student.fullName()} is deleted for #{@course.name}"
    redirect_to courses_path
  end
end
