require 'spec_helper'

RSpec.describe StudentApplicationsController , :type => :controller  do
  before(:each) do
    #seed the database
    seed
    login_admin
  end



  context "without render_views" do
    describe "GET 'index' of student application controller" do
      it "should return successful response" do
        get :index
        # byebug
        expect(response).to be_success
        expect(response).to render_template(:index)
      end
    end
  end


  context "with render_views" do
    render_views
    describe "GET 'index' of student application controller" do
      it 'should return successful response correct html' do
        get :index
        expect(response).to be_success
        expect(response).to render_template(:index)
        expect(response.body).to match /922003095/im
        expect(response.body).to match /922003095/im
      end
    end

    describe "GET 'new' of student application controller" do
      it "should return successful response and tell user no way to directly apply here" do
        get :new
        expect(response).to be_success
        expect(response).to render_template(:new)
        expect(response.body).to match /There is no way to directly create new student application\./im
      end
    end

    # 这里一块逻辑我不知道怎么回事,因为不知道正常使用怎么到这一条路的
    describe "POST 'create' of student application controller" do
      it "should receive one param student application and redirect with flash" do
        # doubled_student_application = instance_double("StudentApplication", 
        #   { 
        #    :advisor => 'Miamia', 
        #    :gpa => '4.0', :course_taken => 'CSCE-606-601', 
        #    :course_taed => 'CSCE-629-601', :preferred_area => 'Physics', :preferred_course => 'CSCE629', 
        #    :application_pool_id => '2', :user_id => 1, :requester => ""
        #   }
        # )
        # allow(StudentApplication).to receive("create!").and_return(doubled_student_application)
      end
    end

    # Bowei: this route does NOT pass TDD, human view this route shows NoMethodError 我怀疑这条路在现在版本中已经不再使用
    describe "GET 'edit' page of student application controller" do
      it "should return http success" do
        doubled_student_application = instance_double("StudentApplication", 
          { 
           :advisor => 'Miamia', 
           :gpa => '4.0', :course_taken => 'CSCE-606-601', 
           :course_taed => 'CSCE-629-601', :preferred_area => 'Physics', :preferred_course => 'CSCE629', 
           :application_pool_id => '2', :user_id => 1, :requester => ""
          }
        )
        allow(StudentApplication).to receive(:find).and_return(doubled_student_application)
        # byebug
        expect(response).to be_success
        expect(response).to render_template(:edit)
      end
    end

    describe "GET 'withdraw_application' method of student application controller" do
      it "should change application status and redirect_to corresponding application page" do
        get :withdraw_application, {:id => 1}
        expect(response).to redirect_to(student_applications_path(1))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match /s Application was withdrawed./im
      end
    end

    # this route does not pass 我怀疑这条路在现在版本中已经不再使用
    describe "GET 'accept_assignment' method of student application controller" do
      it "should change student application status and redirect" do
        doubled_student_application = instance_double("StudentApplication", 
          { 
           :advisor => 'Miamia', 
           :gpa => '4.0', :course_taken => 'CSCE-606-601', 
           :course_taed => 'CSCE-629-601', :preferred_area => 'Physics', :preferred_course => 'CSCE629', 
           :application_pool_id => '2', :user_id => 1, :requester => ""
          }
        )
        allow(StudentApplication).to receive(:find).and_return(doubled_student_application)
        allow(doubled_student_application).to receive(:save!)
        get :accept_assignment, {:id => 1}
        expect(response).to redirect_to( student_applications_path(doubled_student_application))

      end
    end

    # this route does not pass, 我怀疑这条路在现在版本中已经不再使用
    describe "GET 'reject_assignment' method of student application controller" do
      it "should change student application status and redirect" do
        doubled_student_application = instance_double("StudentApplication", 
          { 
           :advisor => 'Miamia', 
           :gpa => '4.0', :course_taken => 'CSCE-606-601', 
           :course_taed => 'CSCE-629-601', :preferred_area => 'Physics', :preferred_course => 'CSCE629', 
           :application_pool_id => '2', :user_id => 1, :requester => ""
          }
        )
        allow(StudentApplication).to receive(:find).and_return(doubled_student_application)
        allow(doubled_student_application).to receive(:save!)
        get :reject_assignment, {:id => 1}
        expect(response).to redirect_to( student_applications_path(doubled_student_application))
      end
    end

  end # end of with render_view do 

end
