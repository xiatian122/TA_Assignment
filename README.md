# TA_Assignment
Project of CSCE 606

preq: ruby: ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
      rails: 4.2.4


start command:
cd to parent folder you would like to hold TA assignment 
$ cd (...parent folder..)
$ git clone https://github.com/TAMUBazinga/TA_Assignment.git
$ git checkout develop
$ bundle install --without production
$ rake db:migrate
$ rails server

(under unbuntu condition, some OS might need to check http://0.0.0.0/students )
open browser, "http://locolhost:3000/students"  


ignore file: 
https://github.com/github/gitignore/blob/master/Rails.gitignore

Git Team Work Protocol
please refer to 
http://code.tutsplus.com/tutorials/focusing-on-a-team-workflow-with-git--cms-22514
for teamwork git usage guideline