require 'spec_helper'

RSpec.describe StudentApplicationsController , :type => :controller  do
  before(:each) do
    #seed the database
    seed
    login_admin
  end

  context "without render_views" do
    describe "GET 'index' of student application controller" do
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
    describe "GET 'index' of student application controller" do
      it 'should return successful response correct html' do
        get :index
        expect(response).to be_success
        expect(response).to render_template(:index)
        expect(response.body).to match /922003095/im
        expect(response.body).to match /922003095/im
      end
    end
  end # end of with render_view do 

end
