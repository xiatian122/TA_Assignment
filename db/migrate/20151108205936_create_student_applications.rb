class CreateStudentApplications < ActiveRecord::Migration
  def up
    create_table :student_applications do |t|
      t.string :advisor
      t.float :gpa
      t.string :course_taken
      t.string :course_taed
      t.string :preferred_area
      t.string :preferred_course
      t.integer :application_pool_id
      t.integer :user_id
      t.integer :active_term
      t.text :note
      t.string :requester
      
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :student_applications
  end
end
