require 'spec_helper'

RSpec.describe StudentApplicationsController , :type => :controller  do
  before(:each) do
    #seed the database
    seed
    login_admin
  end



  context "without render_views" do

    describe "GET 'index' of student application" do
      it "should return successful response" do
        get :index
        # byebug
        expect(response).to be_success
        expect(response).to render_template(:index)
      end
    end

  end


  context "with render_views" do
    render_views
    describe "GET 'index' of student applications" do
      it 'should return successful response correct html' do
        get :index
        expect(response).to be_success
        expect(response).to render_template(:index)
        expect(response.body).to match /922003095/im
        expect(response.body).to match /922003095/im
      end
    end

    describe "GET 'new' of student applications" do
      it "should return successful response and tell user no way to directly apply here" do
        get :new
        expect(response).to be_success
        expect(response).to render_template(:new)
        expect(response.body).to match /There is no way to directly create new student application\./im
      end
    end

    
  end

end
