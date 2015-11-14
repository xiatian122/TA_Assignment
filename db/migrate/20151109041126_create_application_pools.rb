class CreateApplicationPools < ActiveRecord::Migration
  def change
    create_table :application_pools do |t|
    	t.string :year
      t.string :semester
      t.datetime :deadline
      t.boolean :active
      
      t.timestamps null: false
    end
  end
end
