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
          {:password => 'password', :password_confirmation => 'password', :first_name => 'John', :last_name => "Keyser", :uin => '111111111', :email => 'test7@gmail.com', :identity => 'ADMIN', :start_semester => '1989 Spring', :elpe => '0', :guaranteed => '0', :active => '1'}]
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
              {:year => '2015', :semester => 'Spring', :deadline => '2015-1-7 11:59:59', :active => false}]

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
    application_pool_id: 1,
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
    application_pool_id: 1,
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
    application_pool_id: 1,
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
  },
  {
    cid: "CSCE313",
    name: "INTRO TO COMPUTER SYSTEM",
    section: "955",
    lecturer_uin: "719337423",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE314",
    name: "PROGRAMMING LANGUAGES",
    section: "497",
    lecturer_uin: "431587106",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE315",
    name: "PROGRAMMING STUDIO",
    section: "816",
    lecturer_uin: "801317392",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE410",
    name: "OPERATING SYSTEMS",
    section: "857",
    lecturer_uin: "759891470",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE411",
    name: "DESIGN ANALY ALGORITHMS",
    section: "845",
    lecturer_uin: "865303976",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE420",
    name: "ARTIFICIAL INTELLIGENCE",
    section: "653",
    lecturer_uin: "380413844",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE434",
    name: "COMPILER DESIGN",
    section: "786",
    lecturer_uin: "553460407",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE435",
    name: "PARALLEL COMPUTING",
    section: "337",
    lecturer_uin: "656717276",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE436",
    name: "COMP HUMAN INTERACTION",
    section: "751",
    lecturer_uin: "342803160",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE441",
    name: "COMPUTER GRAPHICS",
    section: "324",
    lecturer_uin: "365021554",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE444",
    name: "INTERACTIVE INFORMATION",
    section: "330",
    lecturer_uin: "397582726",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE462",
    name: "MICROCOMPUTER SYSTEMS",
    section: "602",
    lecturer_uin: "154215103",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE464",
    name: "WIRELESS AND MOBILE SYS",
    section: "132",
    lecturer_uin: "656134216",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE481",
    name: "SEMINAR",
    section: "195",
    lecturer_uin: "731820863",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE482",
    name: "SR CAPSTONE DESIGN",
    section: "360",
    lecturer_uin: "723929690",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE483",
    name: "COMPUTER SYS DESIGN",
    section: "481",
    lecturer_uin: "354899642",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE485",
    name: "DIRECTED STUDIES",
    section: "589",
    lecturer_uin: "223106874",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE489",
    name: "SPECIAL TOPICS IN",
    section: "360",
    lecturer_uin: "784295811",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE491",
    name: "RESEARCH",
    section: "602",
    lecturer_uin: "842047925",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE604",
    name: "PROG LANGUAGE DESIGN",
    section: "792",
    lecturer_uin: "820966366",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE606",
    name: "SOFTWARE ENGINEERING",
    section: "572",
    lecturer_uin: "693469903",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE608",
    name: "DATABASE SYSTEMS",
    section: "352",
    lecturer_uin: "812129909",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE611",
    name: "OPERATING SYSTEMS &amp; APPL",
    section: "294",
    lecturer_uin: "826512088",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE614",
    name: "COMPUTER ARCHITECTURE",
    section: "319",
    lecturer_uin: "507824053",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE617",
    name: "GENERIC PROGRAMMING",
    section: "919",
    lecturer_uin: "345481091",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE622",
    name: "SKETCH RECOGNITION",
    section: "953",
    lecturer_uin: "850386122",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE624",
    name: "ARTIFICIAL INTELLIGNCE",
    section: "885",
    lecturer_uin: "176712161",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE625",
    name: "ANALYSIS OF ALGORITHMS",
    section: "134",
    lecturer_uin: "132349652",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE629",
    name: "INTELL USER INTERFACE",
    section: "917",
    lecturer_uin: "473082935",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE634",
    name: "GEOMETRIC MODELING",
    section: "392",
    lecturer_uin: "313442206",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE645",
    name: "DIGITAL IMAGE",
    section: "947",
    lecturer_uin: "233666547",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE646",
    name: "PHYSIC BASED MODELING",
    section: "966",
    lecturer_uin: "872520702",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE649",
    name: "HPC EARTH SCIENCE &amp; PETE",
    section: "427",
    lecturer_uin: "615399927",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE657",
    name: "ADV NETWORK &amp; SECURITY",
    section: "281",
    lecturer_uin: "747308671",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE663",
    name: "TEST &amp; DIAG DIGITAL SYST",
    section: "682",
    lecturer_uin: "494101077",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE665",
    name: "SEMINAR",
    section: "262",
    lecturer_uin: "320220146",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE680",
    name: "PROFESSIONAL INTERNSHIP",
    section: "580",
    lecturer_uin: "979994035",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE681",
    name: "DIRECTED STUDIES",
    section: "372",
    lecturer_uin: "569685977",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE684",
    name: "SPECIAL TOPICS IN",
    section: "392",
    lecturer_uin: "626563449",
    area: "Theory",
    credits: 3,
    application_pool_id: 1,
    suggestion: "",
    notes: ""
  },
  {
    cid: "CSCE685",
    name: "RESEARCH",
    section: "874",
    lecturer_uin: "350191373",
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