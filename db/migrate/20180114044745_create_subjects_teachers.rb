class CreateSubjectsTeachers < ActiveRecord::Migration
  def change
    create_table :subjects_teachers, id: false do |t|
      t.references :subject, index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: true
    end
  end
end
