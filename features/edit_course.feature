Feature: Edit course
  As a root
  I should be able to course list


Background: courses in database
  Given data base has been seeded


Scenario: edit one course
  When I log in as ADMIN
  Given I am on the course home page
  Then I should see "PROGRAMMING I"
  When I follow "edit-1"
  Then I should see "Course ID"
  Then I should see "Advisor"
  When I fill in the following:
    | course[credits]  | 3                     |
    | course[lecturer] | Shaoming Huang        |
    | course[insemail] | bowei_liu@ymail.com   |
  When I press "Update"
  Then I should be on the course home page
  Then I should see "Shaoming Huang"

Scenario: delete one course
  When I log in as ADMIN
  Given I am on the edit page of course_id 1
  When I press "Delete"
  When I should be on the course home page
  Then I should not see "CSCE110"
  Then I should not see "PROGRAMMING I"