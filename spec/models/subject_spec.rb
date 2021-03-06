require 'rails_helper'

RSpec.describe Subject, type: :model do
  context 'subject validation' do
    it 'should be valid subject' do
      FactoryGirl.build(:subject).should be_valid
    end

    it 'should be invalid without a name' do
      FactoryGirl.build(:subject, name: nil).should_not be_valid
    end
  end

  context 'subject associations' do
    it 'should has many teachers' do
      school = FactoryGirl.create(:school)
      @subject = FactoryGirl.create(:subject)
      @teacher1 = FactoryGirl.create(:teacher, school_id: school.id)
      @teacher2 = FactoryGirl.create(:teacher, school_id: school.id)
      @subject.teachers << @teacher1
      @subject.teachers << @teacher2
      @subject.teachers.should include @teacher1
      @subject.teachers.should include @teacher2
    end

    it 'should not has unincluded teachers' do
      school = FactoryGirl.create(:school)
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      @teacher1 = FactoryGirl.create(:teacher, school_id: school.id)
      @teacher2 = FactoryGirl.create(:teacher, school_id: school.id)
      @subject1.teachers << @teacher1
      @subject2.teachers << @teacher2
      @subject1.teachers.should include @teacher1
      @subject1.teachers.should_not include @teacher2
      @subject2.teachers.should include @teacher2
      @subject2.teachers.should_not include @teacher1
    end

    it 'should has many students' do
      school = FactoryGirl.create(:school)
      classroom = FactoryGirl.create(:classroom, school_id: school.id)
      @subject = FactoryGirl.create(:subject)
      @student1 = FactoryGirl.create(:student, classroom_id: classroom.id)
      @student2 = FactoryGirl.create(:student, classroom_id: classroom.id)
      @subject.students << @student1
      @subject.students << @student2
      @subject.students.should include @student1
      @subject.students.should include @student2
    end

    it 'should not has unincluded students' do
      school = FactoryGirl.create(:school)
      classroom = FactoryGirl.create(:classroom, school_id: school.id)
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      @student1 = FactoryGirl.create(:student, classroom_id: classroom.id)
      @student2 = FactoryGirl.create(:student, classroom_id: classroom.id)
      @subject1.students << @student1
      @subject2.students << @student2
      @subject1.students.should include @student1
      @subject1.students.should_not include @student2
      @subject2.students.should include @student2
      @subject2.students.should_not include @student1
    end
  end
end
