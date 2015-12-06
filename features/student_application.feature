Feature: Manage application
  As a student
  I should be able to submit and withdraw an application


Background: Users are created
  Given data base has been seeded


Scenario: Submit application
  When I am on the login page
  When I fill in "Uin" with "922773024"
  When I fill in "Password" with "password"
  When I press "Log in"
  Then I should be on the information page for Tian Xia
  When I follow "Apply"
  Then I should be on submit my application page
  Then I should see "TA Application Form"
  When I fill in the following:
    | student_application[advisor]        | Duncan Walker      |
    | student_application[gpa]            | 4.0                |
    | student_application[preferred_area] | Machine Learning   |
  When I press "Submit"
  Then I should be on the information page for Tian Xia
  Then I should see "Under Review"

Scenario: Withdraw application
  When I am on the login page
  When I fill in "Uin" with "922003095"
  When I fill in "Password" with "password"
  When I press "Log in"
  Then I should be on the information page for Chen Yang
  When I follow "Withdraw"
  Then I should be on the information page for Chen Yang
  Then I should not see "Withdraw"
  Then I should see "Apply"