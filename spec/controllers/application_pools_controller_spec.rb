require 'spec_helper'

RSpec.describe ApplicationPoolsController , :type => :controller  do
  #prepare basic db
  before(:each) do

    admin = {
      :password => 'password', 
      :password_confirmation => 'password', 
      :first_name => 'John', 
      :last_name => "Keyser", 
      :uin => '111111111', 
      :email => 'test7@gmail.com', 
      :identity => 'ADMIN', 
      :start_semester => '1989 Spring', 
      :elpe => '0', 
      :guaranteed => '0', 
      :active => '1'
    }
    User.create!(admin)
    login_admin
    application_pools = [{:year => '2015', :semester => 'Fall', :deadline => '2015-12-25 11:59:59', :active => true}]

    application_pools.each do |application_pool|
      ApplicationPool.create!(application_pool)
    end

  end 

  # GET index method, one method of resources
  describe "GET 'index' of application pool" do
    it "should return successful response" do
      get :index
      # byebug
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  # GET new method, one method of resources utility
  describe "GET 'new'" do
    it "should return sccessful" do
      get :new
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end

  # POST create method, one method of resources utility
  describe "POST 'create'" do
    it "should be redirected when post new application_pool instance" do
      post 'create', {:year => '2016', :semester => 'Spring', :deadline => '2015-1-7 11:59:59', :active => false}
      expect(response).to redirect_to(application_pools_path)
    end
  end

  # GET edit method, one method of resources utility
  describe "GET 'edit'" do
    it "should return successful response when I get edit page of some instance" do
      doubled_application_season = instance_double("ApplicationPool", 
        {:year => '2016', :semester => 'Spring', :deadline => '2015-1-7 11:59:59', :active => false})
      allow(ApplicationPool).to receive(:find).and_return(doubled_application_season)
      get :edit, {:id=> '1'}
      expect(response).to be_success
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH 'update'" do
    it "should redirect when PATCHED" do
      # I do not need to use double, I can use 'before' seeded application_pool instance
      patch :update, {:id =>'1', :application_pool => {:year => '2015', :semester => 'Fall', :deadline => '2015-1-8 11:59:59', :active => 'active'}}
      expect(response).to redirect_to(application_pools_path)
      expect(flash[:success]).to be_present
      expect(flash[:success]).to match /was successfully updated/im
    end
  end

end
