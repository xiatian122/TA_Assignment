class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(:identity, :uin)
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    if @user.identity == "FACULTY"
      redirect_to lecturer_show_path(@user)
    else
      #Get all application pools that are currently active
      @application_pools = ApplicationPool.where(:active => true)
      @studentapplications = Hash.new
      @application_status = Hash.new 
      @available_application_pool = false

      #For each active application pool, see if this user has applied
      @application_pools.each do |application_pool|
        if application_pool.canApply
          @available_application_pool = true
        end  
        
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
      render :show
    end
  end
  
  
  # GET /users/modify/uploadusers
  def uploadusers
    
    @client = Google::APIClient.new(
      :application_name => 'bazinga',
      :application_version => '1.0.0'
    )
    @auth = @client.authorization
    # Bowei Liu: @Xia Tian, I would like to suggest put sensitive info into system environment variables 
    @auth.client_id = CONSTANTS['google_client_id']
    @auth.client_secret = CONSTANTS['google_client_secret']
    @auth.scope = CONSTANTS['google_client_scope']
      
    @auth.redirect_uri = CONSTANTS['google_verify_redirect_uri']
    @auth_uri = @auth.authorization_uri.to_s

  end
  
  # GET /users/modify/process_user_import
  def process_user_import
  
     if params[:code] == "" || params[:url] == ""
      flash[:danger] = "Please get the code and paste the url before clicking import"
      redirect_to users_path + "/modify/uploadusers"
      return
    end
    

    ## Establish Google connection
    @client = Google::APIClient.new(
      :application_name => 'bazinga',
      :application_version => '1.0.0'
    )
    @auth = @client.authorization

    
    @auth.client_id = CONSTANTS['google_client_id']
    @auth.client_secret = CONSTANTS['google_client_secret']
    @auth.scope = CONSTANTS['google_client_scope']
    @auth.redirect_uri = CONSTANTS['google_verify_redirect_uri']
    
    @auth.code = params[:code]
    @url = params[:url]
    
    begin
      @auth.fetch_access_token!
    rescue Exception
    end
  
    if @auth.access_token.nil?
      flash[:danger] = "Please get the code and paste the url before clicking import"
      redirect_to users_path + "/modify/uploadusers"
      return
    end
    @my_session = GoogleDrive.login_with_oauth(@auth.access_token)
    begin
      @ws = @my_session.spreadsheet_by_url(@url).worksheets[0]
    rescue Exception
    end
    
    if @ws.nil?
      flash[:danger] = "Please make sure the code and url correnct: Try Again!"
      redirect_to users_path + "/modify/uploadusers"
      return
    end

    
    
    @row_num = @ws.num_rows - 1
    @col_num = @ws.num_cols
    
    
    @data = []
    @name_parts = []
    @current_user = []
    
    if @col_num == 4
     (1..@row_num).each do |i|
       
        ## Split name into first_name & last_name
        @name_parts = @ws[i+1, 2].split(" ")
        @first_name = @name_parts[0]
        
        ## Deals with Middle Name
        if @name_parts.size == 3
          @last_name = @name_parts[1] + " " + @name_parts[2]
        else
          @last_name = @name_parts[1]          
        end
        
        ## Find the data if it exists, if exist update
        @current_user = User.find_by(:uin => @ws[i+1, 1])
        
        if @current_user.nil?
        
          @data << User.new(
            :uin      => @ws[i+1, 1],
            :first_name => @first_name,
            :last_name  => @last_name,
            :email    => @ws[i+1, 3],
            :identity => @ws[i+1, 4].upcase,
            :password => "password",
            :password_confirmation => "password"
            )
        else
          @current_user.first_name = @first_name
          @current_user.last_name = @last_name
          @current_user.email = @ws[i+1, 3]
          @current_user.identity = @ws[i+1, 4].upcase
          @current_user.save!
        end
      end
      User.import @data
    elsif @col_num == 5
      (1..@row_num).each do |i|
       
        ## Split name into first_name & last_name
        @name_parts = @ws[i+1, 2].split(" ")
        @first_name = @name_parts[0]
        
        ## Deals with Middle Name
        if @name_parts.size == 3
          @last_name = @name_parts[1] + " " + @name_parts[2]
        else
          @last_name = @name_parts[1]          
        end
        
        ## Find the data if it exists, if exist update
        @current_user = User.find_by(:uin => @ws[i+1, 1])
        
        if @current_user.nil?
        
          @data << User.new(
            :uin      => @ws[i+1, 1],
            :first_name => @first_name,
            :last_name  => @last_name,
            :email    => @ws[i+1, 3],
            :identity => @ws[i+1, 4].upcase,
            :elpe     => @ws[i+1, 5],
            :password => "password",
            :password_confirmation => "password"
            )
        else
          @current_user.first_name = @first_name
          @current_user.last_name = @last_name
          @current_user.email = @ws[i+1, 3]
          @current_user.identity = @ws[i+1, 4].upcase
          @current_user.elpe = @ws[i+1, 5]
          @current_user.save!
        end
      end
      User.import @data
    else
      flash[:danger] = "The spreadsheet is wrong: not 4 columns"
      redirect_to users_path + "/modify/uploadusers"
      return
    end
    redirect_to users_path
  end
  
  # POST /users/modify/email_user
  def email_user
    @uin = params[:uin]
    @user = User.find_by(:uin => @uin)
    @msg = params[:email_body]
    ## Sent mail to @user
    UserNotifier.send_ta_notification(@user, @msg).deliver_now
    render json:{"uin"=>@user.uin, "user_name"=>@user.name, "status"=>"success", "operation"=>"email"}
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
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { 
          redirect_to @user 
          flash[:success]="User #{@user.name} was successfully created."
        }
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
    @user = User.find params[:id]
    respond_to do |format|
      if @user.update(params[:user])
        format.html { 
          flash[:success] = "User #{@user.name} was successfully updated."
          redirect_to @user          
        }
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
      format.html { 
        redirect_to users_url
        flash[:success] = 'User was successfully destroyed.' 
      }
      format.json { head :no_content }
    end
  end

  #create new student_application for a application_pool
  def new_application
    @user = User.find(params[:id])
    @application_pool = ApplicationPool.find(params[:term_id])
    if not @application_pool.canApply
      flash[:danger] = "Deadline has passed!"
      redirect_to user_path @user.id
    else
      @studentapplication = StudentApplication.new
      @studentapplication.user_id = @user.id
    end
  end

  #Save the newly created student_application
  def create_ta_application
    @user = User.find(params[:id])
    @application_pool = ApplicationPool.find(params[:term_id])
    @studentapplication = StudentApplication.create!(params[:student_application])
    @studentapplication.application_pool_id = params[:term_id]
    @studentapplication.user_id = @user.id
    @studentapplication.save
    flash[:success] = "#{@studentapplication.fullName()} is created!"
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

    flash[:success] = "TA application is withdrawed!"
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
    flash[:success] = "#{@studentapplication.fullName()} is updated!"
    redirect_to user_path(@user.id)
  end

  def accept_ta_assignment
    @user = User.find(params[:id])
    @matching = AppCourseMatching.find params[:match_id]
    @course = Course.find @matching.course_id
    @matching.status = StudentApplication::STUDENT_CONFIRMED
    @matching.save

    flash[:success] = "TA assignment for #{@course.name} is accepted!"
    redirect_to user_path(@user.id)
  end

  def reject_ta_assignment
    @user = User.find(params[:id])
    @matching = AppCourseMatching.find params[:match_id]
    @course = Course.find @matching.course_id
    @matching.status = StudentApplication::STUDENT_REJECTED
    @matching.save

    flash[:info] = "TA assignment for #{@course.name} is rejected!"
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
  
  #Submit_ta_suggestion will delete the previous suggestion information and submit the new one
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
    # suggestion attribute of courses are strings in the form "ta_name1;ta_id1/ta_name2;ta_id2..." 
    @course.suggestion = nil
    if params[:ids]
      new_tas = params[:ids].keys
      if not new_tas.empty?
        new_tas.each do |ta_id|
          studentapplication = StudentApplication.find(ta_id)
          if @course.suggestion != nil and @course.suggestion.length != 0
            @course.suggestion << '/' + studentapplication.first_name + ' ' + studentapplication.last_name + ';' + "#{ta_id}"
          else
            @course.suggestion = studentapplication.first_name + ' ' + studentapplication.last_name+ ';' +"#{ta_id}"
          end
          if studentapplication.requester != nil and studentapplication.requester.length != 0
            studentapplication.requester = studentapplication.requester + ',' + "#{@course.id}"
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

      if @ta != nil  # Bowei Liu Nov 25 try resolving

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
      params.require(:user).permit(:name, :uin, :email, :password,
                                   :password_confirmation)
    end
    
end
