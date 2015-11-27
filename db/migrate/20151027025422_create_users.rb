class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :uin
      t.string :email
      t.string :identity
      t.string :start_semester
      t.string :elpe
      t.boolean :guaranteed
      t.boolean :active
      

      t.timestamps null: false
    end
  end
end
