# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /^the login\s?page$/
      '/login'
    when /^the home\s?page$/
      '/'
    when /^the student home\s?page$/
      '/students'
    when /^an individual student page$/
      '/students/1'  
      
    when /^the course home\s?page$/
      '/courses'
    when /^the edit page of course_id \d+/
      '/courses/'+ page_name.match(/\d+/)[0] +'/edit'

    when /^page for selecting TA for course_id \d+$/
      '/courses/'+ page_name.match(/\d+/)[0] +'/select_new_ta'
    
    when /^the information page for Tian Xia$/
      '/users/4'
      
    when /^submit my application\s?page$/
      '/users/4/new_application'
      
    when /^the information page for Chen Yang$/
      '/users/1'
      
    when /^the information page for Duncan Walker$/
      '/users/6/lecturer_show'
      
    when /^submit my suggestion\s?page$/
      '/users/6/edit_suggestion'
      
    
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
