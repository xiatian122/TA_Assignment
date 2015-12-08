require 'spec_helper'

RSpec.describe SessionsController , :type => :controller do
  before(:each) do
    users = [{:password => 'password', :password_confirmation => 'password', :first_name => 'user1', :last_name => "Yang", :uin => '922003095', :email => 'test1@gmail.com', :identity => 'PHD', :start_semester => '2013 Fall', :elpe => '1', :guaranteed => '1', :active => '1' },
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user2', :last_name => "Zhao", :uin => '922773022', :email => 'test2@gmail.com', :identity => 'MS', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user3', :last_name => "Edward", :uin => '922773023', :email => 'test3@gmail.com', :identity => 'MENG', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user4', :last_name => "TT", :uin => '922773024', :email => 'test3@gmail.com', :identity => 'PHD', :start_semester => '2012 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user5', :last_name => "Alex", :uin => '922003096', :email => 'test5@gmail.com', :identity => 'FACULTY', :start_semester => '2000 Fall', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'user6', :last_name => "Asada", :uin => '922003097', :email => 'test6@gmail.com', :identity => 'FACULTY', :start_semester => '1989 Spring', :elpe => '0', :guaranteed => '0', :active => '1'},
              {:password => 'password', :password_confirmation => 'password', :first_name => 'John', :last_name => "Keyser", :uin => '111111111', :email => 'tianxia1992@gmail.com', :identity => 'ADMIN', :start_semester => '1989 Spring', :elpe => '0', :guaranteed => '0', :active => '1'}]
    users.each do |user|
      User.create!(user)
    end
  end
  context "with render_views" do
    render_views
    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        expect(response).to be_success
      end

      it "has has correct html content" do
        get 'new'
        # byebug
        expect(response.body).to match /Log in/im
      end
    end
  end # context with render_views end


  context "without render_views" do
    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        expect(response).to be_success
      end

      it "has has correct html content" do
        get 'new'
        # byebug
        expect(response.body).to eq("")
      end
    end

    describe "POST create" do
      # prepare mocks and stubs 
      it "supplied correct credentials" do
        post 'create',  {:session => {:uin => "111111111", :password => "password" }}
        expect(response).to redirect_to(user_path(:id => 7))
      end

      it "supplied incorrect credentials" do
        post 'create',  {:session => {:uin => "111111111", :password => "wrong_psw" }}
        expect(response).to render_template(:new)
        expect(flash[:danger]).to be_present
        expect(flash[:danger]).to eq("Invalid UIN or Password!")
      end
    end

    describe "delete 'destroy'" do
      it "I log out" do
        # to test log out, I need to log in first
        # insert information into session
        login_admin
        delete 'destroy'
        expect(response).to redirect_to(root_url)
        expect(session[:user_id]).to eq(nil)
      end
    end 

    describe "post 'reset_passwd'" do
      it "supplied incorrect UIN and Name combination" do
        post 'reset_passwd', {:session => {:uin => '111111111', :first_name => "Incorrect_firstname"}}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to be_present
      end
      it "supplied correct UIN and Name combination" do
        post 'reset_passwd', {:session => {:uin => '111111111', :first_name => "John"}}
        expect(flash[:success]).to be_present
        expect(flash[:success]).to  eq("Password has been sent to your email address!")
      end
    end

  end
end
