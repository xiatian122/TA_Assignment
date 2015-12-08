Feature: Suggest TA
  As a lecturer
  I should be able to suggest my preferred ta


Background: Users are created
  Given data base has been seeded


Scenario: Submit suggestion
  When I log in as Professor Duncan
  Then I should be on the information page for Duncan Walker
  When I tap "PROGRAMMING I" in expanded accordian
  Then I should see "Suggest TA"
  When I trace "Suggest TA" in expanded accordian
  Then I should be on submit my suggestion page
  When I check "ids[1]"
  When I press "Submit"
  Then I should be on the information page for Duncan Walker
  Then I should see "Chen Yang"
  

Scenario: Delete suggestion
  When I log in as Professor Duncan
  Then I should be on the information page for Duncan Walker
  Then I should see "Wei Zhao"
  When I tap "CPSC CONCEPTS &amp; PROGRAM" in expanded accordian
  Then I should see "Delete Suggestion"
  When I trace "Delete Suggestion" in expanded accordian
  Then I should not see "Wei Zhao"
  
Scenario: Edit suggestion
  When I log in as Professor Duncan
  Then I should be on the information page for Duncan Walker
  When I tap "CPSC CONCEPTS &amp; PROGRAM" in expanded accordian
  Then I should see "Edit"
  When I trace "Edit" in expanded accordian
  Then I should be on submit my suggestion page
  When I follow "Uncheck All"
  When I check "ids[1]"
  When I press "Update Suggestion"
  Then I should be on the information page for Duncan Walker
  Then I should not see "Wei Zhao"
  Then I should see "Chen Yang"