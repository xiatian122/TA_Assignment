class User < ActiveRecord::Base
	attr_accessible :name, :uin, :email
end
