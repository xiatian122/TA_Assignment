class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :cid
      t.string :name
      t.integer :credits
      t.string :lecturer
      t.string :insemail
      t.string :area
      t.text :description
      t.string :ta
      t.text :notes

      t.timestamps null: false
    end
  end
end
