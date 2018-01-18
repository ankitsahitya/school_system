class CreateStudentsSubjects < ActiveRecord::Migration
  def change
    create_table :students_subjects, id: false do |t|
      t.references :student, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
    end
  end
end
