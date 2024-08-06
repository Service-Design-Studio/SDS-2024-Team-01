Feature: Report User 
    As a User 
    So that I can report my harrass
    I want to be able to make a report

Background:
    # Given I have a user account
    Then I login as a user
    And there is "Help with gardening" request

Scenario: Report User
    Given I am on "All Requests" page
    Then I click on "Help with gardening" request
    Then I click on "Millard Robel" profile
    Then I press on "Report" 
    Then I fill in "Reason for Reporting" with "Inappropriate harrassing"
    Then I press on "Next" 
    Then I press on "Confirm Report" 
    Then I should see a message "User has been reported successfully."

Scenario: Don't want to report user
    Given I am on "All Requests" page
    Then I click on "Help with gardening" request
    Then I click on "Millard Robel" profile
    Then I press on "Report" 
    Then I press on "Back" 
    Then I am on the "Millard Robel Profile" page

Scenario: Decided not to report on second thought
    Given I am on "Help with gardening" page
    Then I click on "Millard Robel" profile
    Then I press on "Report" 
    Then I fill in "Reason for Reporting" with "Inappropriate harrassing"
    Then I press on "Next" 
    Then I press on "Cancel" 
    Then I am on the "Millard Robel Profile" page
   

