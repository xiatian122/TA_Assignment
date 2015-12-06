# require './cucumber_seed.rb'

Given /data base has been seeded/ do
  seed()

end

When /^(?:|I )element press "PROGRAMMING I" in expanded accordian$/ do
  within("#heading1") do
    find('.col-xs-4').click
  end
end


When /^(?:|I )follow "(.+)" in expanded accordian$/ do |link|
  within("#collapse1") do
    click_link(link)
  end
end

When /^(?:|I )tap "PROGRAMMING I" in expanded accordian$/ do
  within("#heading1") do
    find('.col-xs-1').click
  end
end

When /^(?:|I )tap "CPSC CONCEPTS &amp; PROGRAM" in expanded accordian$/ do
  within("#heading2") do
    find('.col-xs-1').click
  end
end

When /^(?:|I )trace "Delete Suggestion" in expanded accordian$/ do
  within("#heading2") do
    click_link("Delete Suggestion")
  end
end

When /^(?:|I )trace "Edit" in expanded accordian$/ do
  within("#heading2") do
    click_link("Edit")
  end
end

When /^(?:|I )trace "Suggest TA" in expanded accordian$/ do
  within("#heading1") do
    click_link("Suggest TA")
  end
end

