# Add a declarative step here for populating the DB with movies.
rows = 0
Given /the following movies exist/ do |movies_table|
  rows = movies_table.rows
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie[:title], :rating => movie[:rating], :release_date => movie[:release_date], :director => movie[:director])
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert (page.body.index(e1)<page.body.index(e2))
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(',')
  if uncheck.nil?
    ratings.each do |rating|
      id = "ratings[#{rating}]"
      check(id)
    end
  else
    ratings.each do |rating|
      id = "ratings[#{rating}]"
      uncheck(id)
    end
  end
end

When /^I press the (.*) button$/ do |button|
  step "I press \"#{button}\""
end

Then /^I should see ratings: (.*)$/ do |ratings|
  ratings_list = ratings.split(',')
  ratings_list.each do |rating|
    movies_list = Movie.where(:rating => rating)
    movies_list.each do |movie|
      step "I should see \"#{movie[:title]}\""
    end    
  end
end

Then /^I should not see ratings: (.*)$/ do |ratings|
  ratings_list = ratings.split(',')
  ratings_list.each do |rating|
    movies_list = Movie.where(:rating => rating)
    movies_list.each do |movie|
      step "I should not see \"#{movie[:title]}\""
    end
  end
end

When /^I check all the ratings$/ do
  movies = Movie.find(:all)
  ratings = []
  movies.each do |movie|
    if !ratings.include?(movie[:rating])
      ratings<<movie[:rating] 
    end
  end
  ratings.each do |rating|
    id = "ratings_" + rating
    check(id)
  end
end

Then /^I should see all the movies$/ do
  movies_list = Movie.find(:all)
  movies = []
  movies_list.each do |movie|
    if !movies.include?(movie[:title])
      movies<<movie[:title] 
    end
  end
  movies.each do |movie|
    step "I should see \"#{movie}\""
  end
  
end

Then /^the director of "(.*)" should be "(.*)"$/ do |title, director|
  movie = Movie.where(:title => title)
  assert director == movie[0][:director]
end







