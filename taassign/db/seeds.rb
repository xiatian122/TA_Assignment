# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
students = [{:uin => '922003095', :first_name => 'Ha', :last_name => 'waka' #, 
#             :adivsor => 'Miamia', :degree => '2', :start_semester => '2015 Fall', 
#             :gpa => '4.0', :position => '1', :course_taken => 'CSCE 606', 
#             :course_taed => 'CSCE 629', :preferred_area => 'Physics', :preferred_course => 'CSCE haha', 
#             :status => '1', :active_term => '1'
            }]

students.each do |student|
  Student.create!(student)
end