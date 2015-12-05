Feature: assign TA to a course

  As a root
  So that I can temporarily assign one TA to one of courses
  So I will email it later

Background: courses in database
  Given data base has been seeded

Scenario: Go to page for selecting TA
  When I log in as ADMIN
  When I go to the course home page
  Then I should see "PROGRAMMING I"
  When I element press "PROGRAMMING I" in expanded accordian
  Then I should see "Add new TA"
  When I follow "Add new TA" in expanded accordian
  Then I should be on page for selecting TA for course_id 1

Scenario: Select one TA and delete one TA
  When I log in as ADMIN
  Given I am on page for selecting TA for course_id 1
  Then I should see "Assign new TA for PROGRAMMING I"
  When I check "ids[1]"
  When I select "Full TA" from "positions[1]"
  When I press "Assign"
  Then I should be on the course home page
  Then I should see "Chen Yang"
  Then I should see "Full TA"
  Then I should see "Temporary Assigned"
  When I follow "Confirm"
  When I go to the course home page
  Then I should see "Assigned"
  When I follow "Delete"
  Then I should see "delete"

