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
    @application_pools = ApplicationPool.where(:active => true)
    @studentapplications = Hash.new
    @application_status = Hash.new 
    @application_pools.each do |application_pool|
      if StudentApplication.exists?(application_pool_id: application_pool.id, user_id: @user.id)
        @studentapplications[application_pool.id] = StudentApplication.find_by(application_pool_id: application_pool.id, user_id: @user.id)
        matchings = AppuserMatching.where(student_application_id: @studentapplications[application_pool.id].id)
        if matchings
          matchings.each do |match|
            user = user.find match.user_id
            if not match.status == StudentApplication::TEMP_ASSIGNED
              if not @application_status[application_pool.id]
                @application_status[application_pool.id] = Array.new
              end
              @application_status[application_pool.id] << {'Matching_id' => match.id, 'user' => user.name, 'Position' => match.position, 'Status' => match.status}
            end
          end
        end
      end
    end
  end

 # GET /users/uploadusers
  def uploadusers
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
  
  # GET /users/process_user_import
  def process_user_import
    if params[:code] == "" || params[:url] == ""
      flash[:notice] = "Please get the code and paste the url before clicking import"
      redirect_to users_path + "/0/uploadusers"
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
      redirect_to users_path + "/0/uploadusers"
      return
    end
    @my_session = GoogleDrive.login_with_oauth(@auth.access_token)
    begin
      @ws = @my_session.spreadsheet_by_url(@url).worksheets[0]
    rescue Exception
    end
    
    if @ws.nil?
      flash[:notice] = "Please make sure the code and url correctly: Try Again!"
      redirect_to users_path + "/0/uploadusers"
      return
    end

    ## Process data in spread sheet: By default, the sheet is 3 cols with column names [course_id, course_title, instructor]
    @row_num = @ws.num_rows - 1
    @col_num = @ws.num_cols
    
    if @col_num % 3 != 0
      flash[:notice] = "The spreadsheet is wrong: more than 3 columns"
      redirect_to users_path + "/0/uploadusers"
      return
    end
    
    ### Fetch data from spreadsheet & insert into db
    @data = []
    
    (1..@row_num).each do |i|
      @data << User.new(
        :uin      => @ws[i+1, 1],
        :name     => @ws[i+1, 2],
        :email => @ws[i+1, 3]
        )
    end
    User.import @data
    
    redirect_to users_path    
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

  def new_application
    @user = User.find(params[:id])
    @application_pool = ApplicationPool.find(params[:term_id])
    @studentapplication = StudentApplication.new
  end

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

  def withdraw_student_application
    @user = User.find(params[:id])
    @studentapplication = StudentApplication.find(params[:app_id])

    #delete all matchings in the matching table
    @matchings = AppuserMatching.where(student_application_id: params[:app_id])
    @matchings.each do |matching|
      matching.destroy
    end

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
    @matching = AppuserMatching.find params[:match_id]
    @user = user.find @matching.user_id
    @matching.status = StudentApplication::STUDENT_CONFIRMED
    @matching.save

    flash[:notice] = "TA assignment for #{@user.name} is accepted!"
    redirect_to user_path(@user.id)
  end

  def reject_ta_assignment
    @user = User.find(params[:id])
    @matching = AppuserMatching.find params[:match_id]
    @user = user.find @matching.user_id
    @matching.status = StudentApplication::STUDENT_REJECTED
    @matching.save

    flash[:notice] = "TA assignment for #{@user.name} is rejected!"
    redirect_to user_path(@user.id)
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
