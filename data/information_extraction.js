// This is a node.js JavaScript, the purpose of this file is to extract information from howdy page
// Author: Bowei
/*
    t.string   "cid"
    t.string   "name"
    t.string   "lecturer"
    t.string   "insemail"
    t.string   "area"
    t.text     "description"
    t.string   "ta"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false


*/

var fs =  require("fs");
function cloneObject(obj) {
    if (obj === null || typeof obj !== 'object') {
        return obj;
    }
 
    var temp = obj.constructor(); // give temp the original obj's constructor
    for (var key in obj) {
        temp[key] = cloneObject(obj[key]);
    }
 
    return temp;
}
/*
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
  }
*/

function getRandomNumberStr ( n ){

  return Math.floor( (0.1 + Math.random() *0.9)  * Math.pow(10,n)).toString();
}

fs.readFile('./courses_summary.html', 'utf8', function fileReadCB(err, data) {
  if (err) throw err;
  var courses = [];
  var dummy_course = {
    cid:'CSCE629',
    name:'Introduction to Algorithms',
    section:"601",
    lecturer_uin:"922003096",         
    area:'Theory', 
    credits:3, 
    application_pool_id:1,
    suggestion:'',
    notes:''
  };
  var courses_summary = data;
  var course_names = [];
  var course_numbers = [];
  courses_summary = courses_summary.split('\n');
  courses_summary.forEach(function (el, index, ar){
    var temp = el.match(/<td class="dddefault" width="35%" text-align="left">([A-Za-z&;\s]+)<\/td>/);
    if (temp){
      course_names = course_names.concat(temp[1]);
    }
    temp = el.match(/<td class="dddefault" width="10%">(\d+)<\/td>/);
    if (temp){
      course_numbers = course_numbers.concat(temp[1]);
    }

  });
  var i = 0;
  for (i = 0; i < course_names.length; i++){
    var temp_course = cloneObject(dummy_course);
    temp_course['cid']="CSCE"+course_numbers[i];
    temp_course['name']=course_names[i];
    temp_course['section'] = getRandomNumberStr(3);
    temp_course['lecturer_uin'] = getRandomNumberStr(9);
    courses.push(temp_course);
  }
  var wstream = fs.createWriteStream('output.txt');
  var to_be_output = JSON.stringify(courses, null, '  ' );
  to_be_output = to_be_output.replace(/\"cid\"/gm,'cid');
  to_be_output = to_be_output.replace(/\"name\"/gm,'name');
  to_be_output = to_be_output.replace(/\"section\"/gm,'section');
  to_be_output = to_be_output.replace(/\"lecturer_uin\"/gm,'lecturer_uin');
  to_be_output = to_be_output.replace(/\"area\"/gm,'area');
  to_be_output = to_be_output.replace(/\"credits\"/gm,'credits');
  to_be_output = to_be_output.replace(/\"application_pool_id\"/gm,'application_pool_id');
  to_be_output = to_be_output.replace(/\"suggestion\"/gm,'suggestion');
  to_be_output = to_be_output.replace(/\"notes\"/gm,'notes');
  wstream.write(to_be_output);
  wstream.end()
  
});