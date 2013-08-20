Feature: Merge Articles
As a blog administrator
In order to merge my articles
I want to be able to merge two articles

Background:
Given the blog is set up
And I am logged into the admin panel

Scenario: Non Admin cannot merge articles
Given I am on the edit article page
And I am not an admin user
Then I should not see Merge articles