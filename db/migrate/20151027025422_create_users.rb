class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uin
      t.string :email
      t.string :login
      t.string :identity

      t.timestamps null: false
    end
  end
end
