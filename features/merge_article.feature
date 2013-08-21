Feature: Merge Articles
As a blog administrator
In order to merge my articles
I want to be able to merge two articles

Background:
Given the blog is set up

Scenario: Non Admin cannot merge articles
Given I am a nonadmin user
And I am on the edit article page
Then I should not be able to merge articles
And show me the page