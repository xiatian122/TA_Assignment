# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

# Bowei added http://stackoverflow.com/questions/10121835/how-do-i-simulate-a-login-with-rspec
# please refer app/controllers/helpers/sessions_helper.rb  written by Yang Chen
module SpecTestHelper   
  def login_admin
    login(:ADMIN)
  end

  def login(identity)
    # following means if 
    user = User.where(:identity => identity.to_s).first if identity.is_a?(Symbol)
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id])
  end

  def log_out
    session.delete(:user_id)
  end
end


module DbSeeder
  def seed
    # This file should contain all the record creation needed to seed the database with its default values.
    # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
    #
    # Examples:
    #
    #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
    #   Mayor.create(name: 'Emanuel', city: cities.first)
    #  Student  degree mapping  {1: "ME", 2:"MS", 3:"PhD" }
    #  Student  status mapping  {1: "Under Review", 2:"Assigned", 3:"Confirm"}
    ApplicationPool.delete_all()
    Course.delete_all()
    User.delete_all()
    StudentApplication.delete_all()
    users = [{:password => 'password', :password_confirmation => 'password', :first_name => 'user1', :last_name => "Yang", :uin => '922003095', :email => 'test1@gmail.com', :identity => 'PHD', :start_semester => '2013 Fall', :elpe => '1', :guaranteed => '1', :active => '1' },
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user2', :last_name => "Zhao", :uin => '922773022', :email => 'test2@gmail.com', :identity => 'MS', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user3', :last_name => "Edward", :uin => '922773023', :email => 'test3@gmail.com', :identity => 'MENG', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user4', :last_name => "TT", :uin => '922773024', :email => 'test3@gmail.com', :identity => 'PHD', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user5', :last_name => "Alex", :uin => '922003096', :email => 'test5@gmail.com', :identity => 'FACULTY', :start_semester => '2000 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user6', :last_name => "Asada", :uin => '922003097', :email => 'test6@gmail.com', :identity => 'FACULTY', :start_semester => '1989 Spring', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'John', :last_name => "Keyser", :uin => '111111111', :email => 'tianxia1992@gmail.com', :identity => 'ADMIN', :start_semester => '1989 Spring', :elpe => '0', :guaranteed => '0', :active => '1'}]
    users.each do |user|
      User.create!(user)
    end

    studentapplications = [{ 
                 :advisor => 'Miamia', 
                 :gpa => '4.0', :course_taken => 'CSCE-606-601', 
                 :course_taed => 'CSCE-629-601', :preferred_area => 'Physics', :preferred_course => 'CSCE629', 
                 :application_pool_id => '1', :user_id => 1, :requester => ""
                },
                {
                 :advisor => 'T_Advisor',
                 :gpa => '4.0', :course_taken => 'CSCE-633-601', 
                 :course_taed => 'CSCE-603-601', :preferred_area => 'Machine Learning', :preferred_course => 'CSCE-603', 
                 :application_pool_id => '1', :user_id => 2, :requester => ""
                },
                {
                 :advisor => 'T_Advisor',
                 :gpa => '4.0', :course_taken => 'CSCE-633-601', 
                 :course_taed => 'CSCE-603-601', :preferred_area => 'Compiler Design', :preferred_course => 'CSCE-603', 
                 :application_pool_id => '1', :user_id => 3, :requester => ""
                }
            ]

    studentapplications.each do |studentapplication|
      StudentApplication.create!(studentapplication)
    end

    application_pools = [{:year => '2015', :semester => 'Fall', :deadline => '2015-11-25 11:59:59', :active => true},
                  {:year => '2016', :semester => 'Spring', :deadline => '2015-1-7 11:59:59', :active => false}]

    application_pools.each do |application_pool|
      ApplicationPool.create!(application_pool)
    end

    courses = [
      {
        cid: "CSCE110",
        name: "PROGRAMMING I",
        section: "823",
        lecturer_uin: "922003096",
        area: "Theory",
        credits: 3,
        application_pool_id: 1,
        suggestion: "",
        notes: ""
      },
      {
        cid: "CSCE111",
        name: "CPSC CONCEPTS &amp; PROGRAM",
        section: "739",
        lecturer_uin: "922003097",
        area: "Theory",
        credits: 3,
        application_pool_id: 1,
        suggestion: "",
        notes: ""
      },
      {
        cid: "CSCE121",
        name: "INTRO PGM DESIGN CONCEPT",
        section: "283",
        lecturer_uin: "922003097",
        area: "Theory",
        credits: 3,
        application_pool_id: 1,
        suggestion: "",
        notes: ""
      },
      {
        cid: "CSCE181",
        name: "INTRO TO COMPUTING",
        section: "604",
        lecturer_uin: "181996473",
        area: "Theory",
        credits: 3,
        application_pool_id: 2,
        suggestion: "",
        notes: ""
      },
      {
        cid: "CSCE206",
        name: "STRUCTURED PROG IN C",
        section: "636",
        lecturer_uin: "963009355",
        area: "Theory",
        credits: 3,
        application_pool_id: 2,
        suggestion: "",
        notes: ""
      },
      {
        cid: "CSCE221",
        name: "DATA STRUC &amp; ALGORITHM",
        section: "101",
        lecturer_uin: "821516991",
        area: "Theory",
        credits: 3,
        application_pool_id: 2,
        suggestion: "",
        notes: ""
      },
      {
        cid: "CSCE222",
        name: "DISCRETE STRUC COMPUTING",
        section: "386",
        lecturer_uin: "135251000",
        area: "Theory",
        credits: 3,
        application_pool_id: 1,
        suggestion: "",
        notes: ""
      },
      {
        cid: "CSCE312",
        name: "COMPUTER ORGANIZATION",
        section: "131",
        lecturer_uin: "394958963",
        area: "Theory",
        credits: 3,
        application_pool_id: 1,
        suggestion: "",
        notes: ""
      }
    ];
    courses.each do |course|
      Course.create!(course)
    end
  end
end

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explictly tag your specs with their type, e.g.:
  #
  #     describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/v/3-0/docs
  config.infer_spec_type_from_file_location!

  # added by Bowei, To get this working in your tests, 
  # you have to manually insert the user information into the session. Here's part of what we use at work:
  config.include SpecTestHelper, :type => :controller
  config.include DbSeeder, :type => :controller
end

