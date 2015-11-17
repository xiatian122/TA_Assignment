class CoursesController < ApplicationController
  include CoursesHelper
  before_filter :check_for_cancel, :check_for_delete, :only => [:create, :update]

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
      tadata = StudentApplication.where(id: tadata_ids)  # This will return one list
      @courses_ta[course.id] = tadata
      @ta_status[course.id] = tadata_status

      internal_courses_ta[course.id] = []
      tadata.each_index do |i|
        internal_courses_ta[course.id][i] = tadata[i].attributes
      end      
    end
    @SlotStatus = getSlotStatusForAllCourses(internal_courses_ta)
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
  
  
  # GET /courses/:id
  def upload
    ## :id == 0 => initial visit creates the variable
    ##if params[:id] == 0 && @client.nil?
    @client = Google::APIClient.new(
      :application_name => 'bazinga',
      :application_version => '1.0.0'
    )
    @auth = @client.authorization
    @auth.client_id = "904291423134-kgkglhfmvetflo32ns1phk9fd55gsfvo.apps.googleusercontent.com"
    @auth.client_secret = "fgzHd_4rZ0jQjjEOW5pvZ4RM"
    @auth.scope =
      "https://www.googleapis.com/auth/drive " +
      "https://spreadsheets.google.com/feeds/"
    @auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
    @auth_uri = @auth.authorization_uri.to_s
    ##end
   
      
  end
  
  # GET /courses/:id
  def process_import
    if params[:code] == "" || params[:url] == ""
      flash[:notice] = "Please get the code and paste the url before clicking import"
      redirect_to courses_path + "/0/upload"
      return
    end
      
    ## Establish Google connection
    @client = Google::APIClient.new(
      :application_name => 'bazinga',
      :application_version => '1.0.0'
    )
    @auth = @client.authorization
    @auth.client_id = "904291423134-kgkglhfmvetflo32ns1phk9fd55gsfvo.apps.googleusercontent.com"
    @auth.client_secret = "fgzHd_4rZ0jQjjEOW5pvZ4RM"
    @auth.scope =
      "https://www.googleapis.com/auth/drive " +
      "https://spreadsheets.google.com/feeds/"
    @auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
    
    
    @auth.code = params[:code]
    @url = params[:url]
    
    begin
      @auth.fetch_access_token!
    rescue Exception
    end
  
    if @auth.access_token.nil?
      flash[:notice] = "Please get the code and paste the url before clicking import"
      redirect_to courses_path + "/0/upload"
      return
    end
    @my_session = GoogleDrive.login_with_oauth(@auth.access_token)
    begin
      @ws = @my_session.spreadsheet_by_url(@url).worksheets[0]
    rescue Exception
    end
    
    if @ws.nil?
      flash[:notice] = "Please make sure the code and url correnct: Try Again!"
      redirect_to courses_path + "/0/upload"
      return
    end

    ## Process data in spread sheet: By default, the sheet is 3 cols with column names [course_id, course_title, instructor]
    @row_num = @ws.num_rows - 1
    @col_num = @ws.num_cols
    
    if @col_num % 3 != 0
      flash[:notice] = "The spreadsheet is wrong: more than 3 columns"
      redirect_to courses_path + "/0/upload"
      return
    end
    
    ### Fetch data from spreadsheet & insert into db
    @data = []
    
    (1..@row_num).each do |i|
      @data << Course.new(
        :cid      => @ws[i+1, 1],
        :name     => @ws[i+1, 2],
        :lecturer => @ws[i+1, 3]
        )
    end
    Course.import @data
    
    redirect_to courses_path
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
  
  def check_for_delete
    if params[:commit] == "Delete"
      ## delete the course
      # 
      @course = Course.find(params[:id])

      if @course.exist? && !@course.nil?
        @course.destroy!
        ### Destroy app_course_matching associated with the course
        ### Remains to be solved
        # byebug
      else
        returnflash[:notice] = "The course does not exist! Refresh again!"
      end
      redirect_to courses_path
    end
  end
  
  # GET /courses/#drop_all
  def drop_all
    @course_num = params[:id]
    @courses = Course.all
    @course_app_ids = @courses.uniq.select(:application_pool_id).where.not(:application_pool_id => nil)
    @appcoursematchings = AppCourseMatching.includes(:courses).where("app_course_matchings.application_pool_id = ?")
    if @courses.exists? && !@courses.nil?
      @courses.destroy_all
      #byebug
      ### Destroy all associated appcoursematching
      #if @appcoursematchings.exists? && !@appcoursematchings.nil?
      #  @appcoursematchings.destroy_all
      #end
    end
    redirect_to courses_path
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
   # byebug
    @student_application_info = Hash.new
    @student_application_requesters = Hash.new 

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
    if @course.suggestion != nil
    tasuggestion = @course.suggestion.split('/')
    tasuggestion.each do |ta_info|
      if @suggestion != nil
        @suggestion << '/' + ta_info.split(';')[0]
      else
        @suggestion = ta_info.split(';')[0]
      end
    end
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
    redirect_to(courses_path + "#heading#{id}")
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
    render json:{"ta_id"=>params[:ta_id], "course_id"=>params[:id], "status"=>"success", "operation"=>"email"}
  end

  # Confirm courses/confirm_ta/:id/:ta_id
  def confirm_ta
    @matching = AppCourseMatching.where("student_application_id = ? and course_id = ?", params[:ta_id], params[:id]).first
    @matching.status = StudentApplication::ASSIGNED
    @matching.save!

    @studentapplication = StudentApplication.find(params[:ta_id])
    # @studentapplication.status = StudentApplication::ASSIGNED
    # @studentapplication.save!
    render json:{"ta_id"=>params[:ta_id], "course_id"=>params[:id], "status"=>"success", "operation"=>"confirm"}
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
    render json:{"ta_id"=>params[:ta_id], "course_id"=>params[:id], "status"=>"success", "operation"=>"delete"}
  end
end
