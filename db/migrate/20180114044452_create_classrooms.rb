class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.references :school, index: true, foreign_key: true
      t.integer :room_no
      t.integer :class_no
      t.timestamps null: false
    end
  end
end
