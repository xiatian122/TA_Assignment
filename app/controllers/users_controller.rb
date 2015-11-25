class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    #Get all application pools that are currently active
    @application_pools = ApplicationPool.where(:active => true)
    @studentapplications = Hash.new
    @application_status = Hash.new 

    #For each active application pool, see if this user has applied
    @application_pools.each do |application_pool|

      #If the user has applied, fetch the application form, get matchings, and construct
      #hashtable for saving its application status
      if StudentApplication.exists?(application_pool_id: application_pool.id, user_id: @user.id)
        @studentapplications[application_pool.id] = StudentApplication.find_by(application_pool_id: application_pool.id, user_id: @user.id)
        matchings = AppCourseMatching.where(student_application_id: @studentapplications[application_pool.id].id)
        if matchings
          matchings.each do |match|
            course = Course.find match.course_id
            if not match.status == StudentApplication::TEMP_ASSIGNED
              if not @application_status[application_pool.id]
                @application_status[application_pool.id] = Array.new
              end
              @application_status[application_pool.id] << {'Matching_id' => match.id, 'Course' => course.name, 'Position' => match.position, 'Status' => match.status}
            end
          end
        end
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #create new student_application for a application_pool
  def new_application
    @user = User.find(params[:id])
    @application_pool = ApplicationPool.find(params[:term_id])
    @studentapplication = StudentApplication.new
  end

  #Save the newly created student_application
  def create_ta_application
    @user = User.find(params[:id])
    @application_pool = ApplicationPool.find(params[:term_id])
    @studentapplication = StudentApplication.create!(params[:student_application])
    @studentapplication.application_pool_id = params[:term_id]
    @studentapplication.user_id = @user.id
    @studentapplication.save
    flash[:notice] = "#{@studentapplication.fullName()} is created!"
    redirect_to user_path(@user.id)
  end

  def show_ta_application
    @user = User.find(params[:id])

  end

  #Delete student_application from the table, and purge all matchings in 
  #the matching table
  #TODO: If the student withdraws application, but there already has matchings
  #in the matching table, shouldn't we notify Keyser? Or we just let the
  #student withdraw silently?
  #TODO2: For course requesters, we should purge related information in
  #courses that request this student, too.
  def withdraw_student_application
    @user = User.find(params[:id])
    @studentapplication = StudentApplication.find(params[:app_id])

    #delete all matchings in the matching table
    @matchings = AppCourseMatching.where(student_application_id: params[:app_id])
    @matchings.each do |matching|
      matching.destroy
    end

    #TODO: purge requester information

    @studentapplication.destroy
    redirect_to user_path(@user.id)
  end

  def edit_ta_application
    @user = User.find(params[:id])
    @studentapplication = StudentApplication.find(params[:app_id])
  end

  def update_ta_application
    @user = User.find(params[:id])
    @studentapplication = StudentApplication.find(params[:app_id])
    @studentapplication.update_attributes!(params[:student_application])
    flash[:notice] = "#{@studentapplication.fullName()} is updated!"
    redirect_to user_path(@user.id)
  end

  def accept_ta_assignment
    @user = User.find(params[:id])
    @matching = AppCourseMatching.find params[:match_id]
    @course = Course.find @matching.course_id
    @matching.status = StudentApplication::STUDENT_CONFIRMED
    @matching.save

    flash[:notice] = "TA assignment for #{@course.name} is accepted!"
# <<<<<<< HEAD

# =======
# >>>>>>> develop
    redirect_to user_path(@user.id)
  end

  def reject_ta_assignment
    @user = User.find(params[:id])
    @matching = AppCourseMatching.find params[:match_id]
    @course = Course.find @matching.course_id
    @matching.status = StudentApplication::STUDENT_REJECTED
    @matching.save

    flash[:notice] = "TA assignment for #{@course.name} is rejected!"
    redirect_to user_path(@user.id)
  end

  def edit_suggestion
      @user = User.find params[:id]
      @course = Course.find params[:courseid]
      #@course = Course.find(params[:id])

      @student_application_info = Hash.new
      @student_application_requesters = Hash.new
      @suggestionindex = Array.new

      @studentapplications = StudentApplication.where(application_pool_id: @course.application_pool_id)

      @studentapplications.each do |studentapplication|
      @app_course_matching = AppCourseMatching.where(student_application_id: studentapplication.id)
      info_for_student = Hash.new 
      assignable = true
      assignable_position = Array.new

      #Retrieve status info for each assigned course
      if @app_course_matching.length > 0
        matching_for_student = Array.new
        #if already two half TA, cannot assign
        if @app_course_matching.length == 2
          assignable = false
        elsif @app_course_matching[0].position == AppCourseMatching::FULLTA
          assignable = false
        else
          assignable_position << {AppCourseMatching::HALFTA => 'Half TA'}
        end

        @app_course_matching.each do |app_matching|
          matched_course = Course.find app_matching.course_id 
          matching_for_student <<{'Course' => matched_course.name, 'Position' => app_matching.position, 'app_status' =>app_matching.status } 
        end
        info_for_student['status'] = matching_for_student
      else
        assignable_position << {AppCourseMatching::FULLTA => 'Full TA'}
        assignable_position << {AppCourseMatching::HALFTA => 'Half TA'}
      end
      info_for_student['assignable'] = assignable
      info_for_student['assignable_position'] = assignable_position

      #Retrieve requester info
      @student_application_info[studentapplication.id] = info_for_student
    end
    if @course.suggestion != nil
      coursesuggestion = @course.suggestion.split('/')
      coursesuggestion.each do |taname|
        if taname != nil
          if @suggestionindex != nil
            @suggestionindex << taname.split(';')[1]
          else
            @suggestionindex = taname.split(';')[1]
          end
        end
      end
    else
      @suggestionindex = nil
    end
  end
  
  def submit_ta_suggestion
    id = params[:courseid]
    @course = Course.find_by_id(id) 
    if @course.suggestion != nil
    suggestionid = @course.suggestion.split('/')
    suggestionid.each do |studentid|
      ta_id = studentid.split(';')
      @ta = StudentApplication.find_by_id(ta_id[1])
      if @ta != nil
        if @ta.requester != nil
        courserelated = @ta.requester.split(',')
        @ta.requester = nil
        courserelated.delete("#{id}")
        courserelated.each do |course|
          if @ta.requester != nil
            @ta.requester << ','+course
          else
            @ta.requester = course
          end
        end
        @ta.save!
        end
      end
    end
    end
    @course.suggestion = nil
    if params[:ids]
      new_tas = params[:ids].keys
      if not new_tas.empty?
        new_tas.each do |ta_id|
          studentapplication = StudentApplication.find(ta_id)
          if @course.suggestion != nil
            @course.suggestion << '/' + studentapplication.first_name + ' ' + studentapplication.last_name + ';' + "#{ta_id}"
          else
            @course.suggestion = studentapplication.first_name + ' ' + studentapplication.last_name+ ';' +"#{ta_id}"
          end
          if studentapplication.requester != nil
            studentapplication.requester << ',' + "#{@course.id}"
          else
            studentapplication.requester = "#{@course.id}"
          end
          studentapplication.save!
            # @studentapplication.course_assigned = @course.id
            # @studentapplication.status = StudentApplication::TEMP_ASSIGNED
            # @studentapplication.save!
        end
      end
    end
    @course.save!
    redirect_to(lecturer_show_path(params[:id]))
  end
  
  def delete_suggestion
    id = params[:courseid]
    @course = Course.find_by_id(id)
    if @course.suggestion != nil
    suggestionid = @course.suggestion.split('/')
    suggestionid.each do |studentid|
      ta_id = studentid.split(';')
      @ta = StudentApplication.find_by_id(ta_id[1])
      if @ta != nil
        if @ta.requester != nil
        courserelated = @ta.requester.split(',')
        @ta.requester = nil
        courserelated.delete("#{id}")
        courserelated.each do |course|
          if @ta.requester != nil
            @ta.requester << ','+course
          else
            @ta.requester = course
          end
        end
        @ta.save!
        end
      end
    end
    end
    @course.suggestion = nil
    @course.save!
    redirect_to(lecturer_show_path(params[:id]))
  end
    
  
  def lecturer_show
    @user = User.find params[:id]
    @puin = @user.uin
    #@puin = params[:luin]
    @lecturer = User.find_by_uin(@puin)
    session[:puin] = @puin
    @courselist = Course.where(:lecturer_uin => @puin)
    @courses_ta = Hash.new
    @suggestion = Array.new

    internal_courses_ta = Hash.new  # internal usage
    @ta_status = Hash.new

    @courselist.each do |course|
      tadata_matching = AppCourseMatching.where(course_id: course.id)
      tadata_ids = Array.new
      tadata_status = Hash.new 
      tadata_matching.each do |matching|
        tadata_ids << matching.student_application_id
        tadata_status[matching.student_application_id] = {'status' => matching.status, 'position' => matching.position}
      end
      tadata = StudentApplication.where(id: tadata_ids)  # This will return one list      
      @courses_ta[course.id] = tadata
      @ta_status[course.id] = tadata_status

      if course.suggestion != nil
        @coursesuggestion = course.suggestion.split('/')
        @coursesuggestion.each do |taname|
          if @suggestion[course.id] != nil
            @suggestion[course.id] << '/' + taname.split(';')[0]
          else
            @suggestion[course.id] = taname.split(';')[0]
          end
        end
      else
        @suggestion[course.id] = nil
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :uin, :email, :login)
    end
    
end
