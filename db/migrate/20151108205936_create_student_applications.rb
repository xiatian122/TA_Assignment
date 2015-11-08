class CreateStudentApplications < ActiveRecord::Migration
  def change
    create_table :student_applications do |t|

      t.timestamps null: false
    end
  end
end
