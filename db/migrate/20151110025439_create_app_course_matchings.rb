class CreateAppCourseMatchings < ActiveRecord::Migration
  def change
    create_table :app_course_matchings do |t|
      t.integer :student_application_id
      t.integer :course_id
      t.integer :application_pool_id
      t.integer :status
      t.integer :position

      t.timestamps null: false
    end
  end
end
