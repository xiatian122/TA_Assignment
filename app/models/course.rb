class Course < ActiveRecord::Base
	attr_accessible :cid, :name, :credits, :lecturer, :lecturer_uin, :insemail, :area, :description, :ta, :notes, :application_pool_id, :suggestion
end
