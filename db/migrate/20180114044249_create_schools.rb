class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :phone_no
      t.string :code
      t.timestamps null: false
    end
  end
end
