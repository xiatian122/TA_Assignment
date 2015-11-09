class AddApplicationPoolIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :application_pool_id, :integer
  end
end
