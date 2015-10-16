class Course < ActiveRecord::Base
	attr_accessible :cid, :name, :lecturer, :insemail, :area, :description, :ta, :notes
end
