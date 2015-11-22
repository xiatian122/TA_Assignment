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
users = [{:first_name => 'user1', :last_name => "Yang", :uin => '922003095', :email => 'test1@gmail.com', :identity => 'PhD', :start_semester => '2013 Fall', :elpe => '1', :guaranteed => '1', :active => '1' },
          {:first_name => 'user2', :last_name => "Zhao", :uin => '922773022', :email => 'test2@gmail.com', :identity => 'MS', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
          {:first_name => 'user3', :llast_name => "Edward", :uin => '922773023', :email => 'test3@gmail.com', :identity => 'Meng', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
          {:first_name => 'user4', :last_name => "TT", :uin => '922773024', :email => 'test3@gmail.com', :identity => 'PhD', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
          {:first_name => 'user5', :last_name => "Alex", :uin => '922003096', :email => 'test5@gmail.com', :identity => 'faculty', :start_semester => '2000 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
          {:first_name => 'user6', :last_name => "Asada", :uin => '922003097', :email => 'test6@gmail.com', :identity => 'faculty', :start_semester => '1989 Spring', :elpe => '0', :guaranteed => '0', :active => '1'}]
users.each do |user|
  User.create!(user)
end

studentapplications = [{ 
             :advisor => 'Miamia', 
             :gpa => '4.0', :course_taken => 'CSCE-606-601', 
             :course_taed => 'CSCE-629-601', :preferred_area => 'Physics', :preferred_course => 'CSCE629', 
             :application_pool_id => '1', :user_id => 1
            },
            {
             :advisor => 'T_Advisor',
             :gpa => '4.0', :course_taken => 'CSCE-633-601', 
             :course_taed => 'CSCE-603-601', :preferred_area => 'Machine Learning', :preferred_course => 'CSCE-603', 
             :application_pool_id => '1', :user_id => 2
            },
            {
             :advisor => 'T_Advisor',
             :gpa => '4.0', :course_taken => 'CSCE-633-601', 
             :course_taed => 'CSCE-603-601', :preferred_area => 'Compiler Design', :preferred_course => 'CSCE-603', 
             :application_pool_id => '1', :user_id => 3
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
    section: "601",
    lecturer_uin: "922003096",
    area: "Theory",
    credits: 3,
    :application_pool_id => '1',
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE111601",
    name: "CPSC CONCEPTS &amp; PROGRAM",
    section: "",
    lecturer_uin: "922003097",
    area: "Theory",
    credits: 3,
    :application_pool_id => '1',
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE121",
    name: "INTRO PGM DESIGN CONCEPT",
    section: "",
    lecturer_uin: "922003097",
    area: "Theory",
    credits: 3,
    :application_pool_id => '1',
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE181",
    section: "",
    name: "INTRO TO COMPUTING",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE206",
    section: "",
    name: "STRUCTURED PROG IN C",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE221",
    section: "",
    name: "DATA STRUC &amp; ALGORITHM",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE222",
    section: "",
    name: "DISCRETE STRUC COMPUTING",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE312",
    section: "",
    name: "COMPUTER ORGANIZATION",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE313",
    section: "",
    name: "INTRO TO COMPUTER SYSTEM",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE314",
    section: "",
    name: "PROGRAMMING LANGUAGES",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE315",
    section: "",
    name: "PROGRAMMING STUDIO",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE410",
    section: "",
    name: "OPERATING SYSTEMS",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE411",
    section: "",
    name: "DESIGN ANALY ALGORITHMS",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE420",
    name: "ARTIFICIAL INTELLIGENCE",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE434",
    section: "",
    name: "COMPILER DESIGN",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE435",
    section: "",
    name: "PARALLEL COMPUTING",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE436",
    section: "",
    name: "COMP HUMAN INTERACTION",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE441",
    section: "",
    name: "COMPUTER GRAPHICS",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE444",
    section: "",
    name: "INTERACTIVE INFORMATION",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE462",
    name: "MICROCOMPUTER SYSTEMS",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE464",
    section: "",
    name: "WIRELESS AND MOBILE SYS",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE481",
    name: "SEMINAR",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE482",
    name: "SR CAPSTONE DESIGN",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE483",
    name: "COMPUTER SYS DESIGN",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE485",
    name: "DIRECTED STUDIES",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE489",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE491",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE604",
    name: "PROG LANGUAGE DESIGN",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE606",
    name: "SOFTWARE ENGINEERING",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE608",
    name: "DATABASE SYSTEMS",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE611",
    name: "OPERATING SYSTEMS &amp; APPL",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE614",
    name: "COMPUTER ARCHITECTURE",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE617",
    name: "GENERIC PROGRAMMING",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE622",
    name: "SKETCH RECOGNITION",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE624",
    name: "ARTIFICIAL INTELLIGNCE",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE625",
    name: "ANALYSIS OF ALGORITHMS",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE629",
    name: "INTELL USER INTERFACE",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE634",
    name: "GEOMETRIC MODELING",
   section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE645",
    name: "DIGITAL IMAGE",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE646",
    name: "PHYSIC BASED MODELING",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE649",
    name: "HPC EARTH SCIENCE &amp; PETE",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE657",
    name: "ADV NETWORK &amp; SECURITY",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE663",
    name: "TEST &amp; DIAG DIGITAL SYST",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE665",
    name: "SEMINAR",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE680",
    name: "PROFESSIONAL INTERNSHIP",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE681",
    name: "DIRECTED STUDIES",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE684",
    name: "SPECIAL TOPICS IN",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  },
  {
    cid: "CSCE685",
    name: "RESEARCH",
    section: "",
    area: "Theory",
    credits: 3,
    notes: ""
  }
];

courses.each do |course|
  Course.create!(course)
end