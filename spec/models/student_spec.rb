require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'student validation' do
    it 'should be valid student' do
      FactoryGirl.build(:student).should be_valid
    end

    it 'should be invalid without a school' do
      FactoryGirl.build(:student, school_id: nil).should_not be_valid
    end

    it 'should be invalid without a classroom' do
      FactoryGirl.build(:student, classroom_id: nil).should_not be_valid
    end

    it 'should be invalid without a name' do
      FactoryGirl.build(:student, name: nil).should_not be_valid
    end

    it 'should be invalid without a address' do
      FactoryGirl.build(:student, address: nil).should_not be_valid
    end

    it 'should be invalid without a phone_no' do
      FactoryGirl.build(:student, phone_no: nil).should_not be_valid
    end

    it 'should be invalid without a gender' do
      FactoryGirl.build(:student, gender: nil).should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:student, phone_no: '1234').should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:student, phone_no: 'asdfghj').should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:student, phone_no: '12345678909876543').should_not be_valid
    end

    it 'should be invalid with a invalid gender' do
      FactoryGirl.build(:student, gender: 'asdf').should_not be_valid
    end
  end

  context 'student associations' do
    it 'should has many subjects' do
      @student = FactoryGirl.create(:student)
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      @student.subjects << @subject1
      @student.subjects << @subject2
      @student.subjects.should include @subject1
      @student.subjects.should include @subject2
    end

    it 'should not has unincluded subject' do
      @student1 = FactoryGirl.create(:student)
      @student2 = FactoryGirl.create(:student)
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      @student1.subjects << @subject1
      @student2.subjects << @subject2
      @student1.subjects.should include @subject1
      @student1.subjects.should_not include @subject2
      @student2.subjects.should include @subject2
      @student2.subjects.should_not include @subject1
    end

    it 'should belongs to school' do
      school = FactoryGirl.create(:school)
      student = FactoryGirl.create(:student, school_id: school.id)
      student.school.id.should eq school.id
    end

    it 'should not belong to invalid school' do
      school1 = FactoryGirl.create(:school)
      school2 = FactoryGirl.create(:school)
      student = FactoryGirl.create(:student, school_id: school1.id)
      student.school.id.should eq school1.id
      student.school.id.should_not eq school2.id
    end

    it 'should belongs to classroom' do
      classroom = FactoryGirl.create(:classroom)
      student = FactoryGirl.create(:student, classroom_id: classroom.id)
      student.classroom.id.should eq classroom.id
    end

    it 'should not belong to invalid classroom' do
      classroom1 = FactoryGirl.create(:classroom)
      classroom2 = FactoryGirl.create(:classroom)
      student = FactoryGirl.create(:student, classroom_id: classroom1.id)
      student.classroom.id.should eq classroom1.id
      student.classroom.id.should_not eq classroom2.id
    end
  end
end
