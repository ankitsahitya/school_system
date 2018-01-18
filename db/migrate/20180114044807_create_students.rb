class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :school, index: true, foreign_key: true
      t.references :classroom, index: true, foreign_key: true
      t.string :name
      t.string :address
      t.string :phone_no
      t.string :gender
      t.timestamps null: false
    end
  end
end
