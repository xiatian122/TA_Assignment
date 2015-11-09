class AddApplicationPoolIdToStudentApplications < ActiveRecord::Migration
  def change
    add_column :student_applications, :application_pool_id, :integer
  end
end
