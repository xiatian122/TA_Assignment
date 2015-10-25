# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#  Student  degree mapping  {1: "ME", 2:"MS", 3:"PhD" }
#  Student  status mapping  {1: "Under Review", 2:"Assigned", 3:"Confirm"}
Student.delete_all()
Course.delete_all()

students = [{:uin => '922003095', :first_name => 'Ha', :last_name => 'waka' , 
             :advisor => 'Miamia', :degree => '2', :start_semester => '2015 Fall', 
             :gpa => '4.0', :position => '1', :course_taken => 'CSCE-606-601', 
             :course_taed => 'CSCE-629-601', :preferred_area => 'Physics', :preferred_course => 'CSCE629', 
             :status => '1', :active_term => '20153'
            },
            {:uin => '922773022', :first_name => 'Testfirst', :last_name => 'Testlast' , 
             :advisor => 'T_Advisor', :degree => '3', :start_semester => '2012 Fall', 
             :gpa => '4.0', :position => '3', :course_taken => 'CSCE-633-601', 
             :course_taed => 'CSCE-603-601', :preferred_area => 'Machine Learning', :preferred_course => 'CSCE-603', 
             :status => '3', :active_term => '20153'
            },
            {:uin => '922773022', :first_name => 'Jack', :last_name => 'Sparrow' , 
             :advisor => 'T_Advisor', :degree => '3', :start_semester => '2013 Spring', 
             :gpa => '4.0', :position => '3', :course_taken => 'CSCE-633-601', 
             :course_taed => 'CSCE-603-601', :preferred_area => 'Machine Learning', :preferred_course => 'CSCE-603', 
             :status => '2', :active_term => '20153'
            }

        ]

students.each do |student|
  Student.create!(student)
end

courses = [{:cid => 'CSCE629', :name => 'Introduction to Algorithms', :lecturer => 'ABC',
             :insemail => 'test@test.com', :area => 'Theory', :description => '2015 Fall', 
             :ta => 'N/A', :notes => ''
            }]

courses.each do |course|
  Course.create!(course)
end