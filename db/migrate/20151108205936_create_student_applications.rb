class CreateStudentApplications < ActiveRecord::Migration
  def up
    create_table :student_applications do |t|
      t.string :uin
      t.string :first_name
      t.string :last_name
      t.string :advisor
      t.integer :degree
      t.string :start_semester
      t.float :gpa
      t.integer :position
      t.string :course_taken
      t.string :course_taed
      t.string :preferred_area
      t.string :preferred_course
      t.integer :status
      t.integer :active_term
      t.integer :course_assigned
      
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :student_applications
  end
end
