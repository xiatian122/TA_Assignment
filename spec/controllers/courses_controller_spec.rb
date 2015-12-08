require 'spec_helper'
require 'rails_helper'
include RSpec::Mocks::ExampleMethods
RSpec.describe CoursesController, :type => :controller do
  before(:each) do
    admin = {
      :password => 'password', 
      :password_confirmation => 'password', 
      :first_name => 'John', 
      :last_name => "Keyser", 
      :uin => '111111111', 
      :email => 'test7@gmail.com', 
      :identity => 'ADMIN', 
      :start_semester => '1989 Spring', 
      :elpe => '0', 
      :guaranteed => '0', 
      :active => '1'
    }
    User.create!(admin)
    # debugger
    login_admin  # this method is defined in module SpecTestHelper  at file : "spec_helper.rb"

    real_course = {
      cid: "CSCE110",
      name: "PROGRAMMING I",
      section: "823",
      lecturer_uin: "922003096",
      area: "Theory",
      credits: 3,
      application_pool_id: 1,
      suggestion: "",
      notes: ""
    }
    Course.create!(real_course)

    @doubled_course = instance_double("Course", {
      cid: "CSCE110",
      name: "PROGRAMMING I",
      section: "823",
      lecturer_uin: "922003096",
      area: "Theory",
      credits: 3,
      application_pool_id: 1,
      suggestion: "",
      notes: ""
    })
    @doubled_course2 = instance_double("Course", {
      cid: "CSCE110",
      name: "PROGRAMMING I",
      section: "444",
      lecturer_uin: "913001011",
      area: "Introduction",
      credits: 3,
      application_pool_id: 1,
      suggestion: "",
      notes: ""
    })
  end

  it 'when I go to the edit page for the course (instance of Course ), expect response to be success' do
    # I just give order to Course that  Course.find(3) must return the doubled instance course defined above
    # Course.should_receive(:find).with('3').and_return(course)
    # expect(Course).to receive(:find).with('3').and_return(course)
    allow(Course).to receive(:find).and_return(@doubled_course)
    get :edit, {:id=> '3'}
    # debugger
    expect(response).to be_success
  end


  it 'when I updated course information, response should be redirect to courses' do
    course2 = {
      cid: "CSCE110",
      name: "ABCDEFG",
      section: "444",
      lecturer_uin: "913001011",
      area: "Introduction",
      credits: 3,
      application_pool_id: 1,
      suggestion: "",
      notes: ""
    }
    post(:update, {:id => '1', :course => course2})
    expect(response).to redirect_to(courses_path)
  end

  it "when I new a course" do 
    get :new 
    expect(response).to render_template(:new)
  end

  # detailed test of index should be done in Behaviror Test
  it "when browse index show all courses" do   
    get :index
    expect(response).to render_template(:index)
    expect(response.body).to eq("")
  end

  it "when I logged out, I should have no access to edit course page" do
    log_out() # This method is defined in spec_helper   module:  SpecTestHelper 
    allow(Course).to receive(:find).and_return(@doubled_course)
    get :edit, {:id=> '3'}
    expect(response.status).not_to eql 200
  end
end
