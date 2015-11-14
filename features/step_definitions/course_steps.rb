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
