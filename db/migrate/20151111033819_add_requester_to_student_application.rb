class AddRequesterToStudentApplication < ActiveRecord::Migration
  def change
    add_column :student_applications, :requester, :string
  end
end
