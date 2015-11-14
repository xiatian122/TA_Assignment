module CucumberSeeder
  def seed
    ApplicationPool.delete_all()
    Course.delete_all()
    User.delete_all()
    StudentApplication.delete_all()
    users = [{:name => 'user1', :uin => '922003095', :email => 'test1@gmail.com', :login => 'login1'},
              {:name => 'user2', :uin => '922773022', :email => 'test2@gmail.com', :login => 'login1'},
              {:name => 'user3', :uin => '922773023', :email => 'test3@gmail.com', :login => 'login1'},
              {:name => 'user4', :uin => '922773024', :email => 'test3@gmail.com', :login => 'login1'}]

    users.each do |user|
      User.create!(user)
    end

    studentapplications = [{:uin => '922003095', :first_name => 'Ha', :last_name => 'waka' , 
                 :advisor => 'Miamia', :degree => '2', :start_semester => '2015 Fall', 
                 :gpa => '4.0', :position => '1', :course_assigned => '0', :course_taken => 'CSCE-606-601', 
                 :course_taed => 'CSCE-629-601', :preferred_area => 'Physics', :preferred_course => 'CSCE629', 
                 :status => '1', :active_term => '20153', :application_pool_id => '1', :user_id => 1
                },
                {:uin => '922773022', :first_name => 'Testfirst', :last_name => 'Testlast' , 
                 :advisor => 'T_Advisor', :degree => '3', :start_semester => '2012 Fall', 
                 :gpa => '4.0', :position => '3', :course_assigned => '0', :course_taken => 'CSCE-633-601', 
                 :course_taed => 'CSCE-603-601', :preferred_area => 'Machine Learning', :preferred_course => 'CSCE-603', 
                 :status => '1', :active_term => '20153', :application_pool_id => '1', :user_id => 2
                },
                {:uin => '922773023', :first_name => 'Jack', :last_name => 'Sparrow' , 
                 :advisor => 'T_Advisor', :degree => '3', :start_semester => '2013 Spring', 
                 :gpa => '4.0', :position => '3', :course_assigned => '0', :course_taken => 'CSCE-633-601', 
                 :course_taed => 'CSCE-603-601', :preferred_area => 'Compiler Design', :preferred_course => 'CSCE-603', 
                 :status => '1', :active_term => '20153', :application_pool_id => '1', :user_id => 3
                }
            ]

    studentapplications.each do |studentapplication|
      StudentApplication.create!(studentapplication)
    end

    application_pools = [{:year => '2015', :semester => 'Fall', :deadline => '2015-11-25 11:59:59', :active => true},
                  {:year => '2015', :semester => 'Spring', :deadline => '2015-1-7 11:59:59', :active => false}]

    application_pools.each do |application_pool|
      ApplicationPool.create!(application_pool)
    end

    courses = [
      {
        cid: "CSCE110",
        name: "PROGRAMMING I",
        lecturer: "ABC",
        insemail: "test@test.com",
        area: "Theory",
        description: "2015 Fall",
        ta: "N/A",
        credits: 3,
        :application_pool_id => '1',
        notes: ""
      },
      {
        cid: "CSCE111",
        name: "CPSC CONCEPTS &amp; PROGRAM",
        lecturer: "ABC",
        insemail: "test@test.com",
        area: "Theory",
        description: "2015 Fall",
        ta: "N/A",
        credits: 3,
        :application_pool_id => '1',
        notes: ""
      },
      {
        cid: "CSCE121",
        name: "INTRO PGM DESIGN CONCEPT",
        lecturer: "ABC",
        insemail: "test@test.com",
        area: "Theory",
        description: "2015 Fall",
        ta: "N/A",
        credits: 3,
        :application_pool_id => '1',
        notes: ""
      },
      {
        cid: "CSCE181",
        name: "INTRO TO COMPUTING",
        lecturer: "ABC",
        insemail: "test@test.com",
        area: "Theory",
        description: "2015 Fall",
        ta: "N/A",
        credits: 3,
        notes: ""
      },
      {
        cid: "CSCE206",
        name: "STRUCTURED PROG IN C",
        lecturer: "ABC",
        insemail: "test@test.com",
        area: "Theory",
        description: "2015 Fall",
        ta: "N/A",
        credits: 3,
        notes: ""
      },
      {
        cid: "CSCE221",
        name: "DATA STRUC &amp; ALGORITHM",
        lecturer: "ABC",
        insemail: "test@test.com",
        area: "Theory",
        description: "2015 Fall",
        ta: "N/A",
        credits: 3,
        notes: ""
      }
    ];

    courses.each do |course|
      Course.create!(course)
    end
  end
end

World(CucumberSeeder)