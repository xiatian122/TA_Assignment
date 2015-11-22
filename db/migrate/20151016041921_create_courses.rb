class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :cid
      t.string :section
      t.string :name
      t.integer :credits
      t.string :lecturer_uin
      t.string :area
      t.text :notes
      t.string :suggestion
      t.integer :application_pool_id

      t.timestamps null: false
    end
  end
end
