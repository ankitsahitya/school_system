require 'rails_helper'

RSpec.describe Teacher, type: :model do
  context 'teacher validation' do
    it 'should be valid teacher' do
      FactoryGirl.build(:teacher).should be_valid
    end

    it 'should be invalid without a school' do
      FactoryGirl.build(:teacher, school_id: nil).should_not be_valid
    end

    it 'should be invalid without a name' do
      FactoryGirl.build(:teacher, name: nil).should_not be_valid
    end

    it 'should be invalid without a address' do
      FactoryGirl.build(:teacher, address: nil).should_not be_valid
    end

    it 'should be invalid without a phone_no' do
      FactoryGirl.build(:teacher, phone_no: nil).should_not be_valid
    end

    it 'should be invalid without a gender' do
      FactoryGirl.build(:teacher, gender: nil).should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:teacher, phone_no: '1234').should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:teacher, phone_no: 'asdfghj').should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:teacher, phone_no: '12345678909876543').should_not be_valid
    end

    it 'should be invalid with a invalid gender' do
      FactoryGirl.build(:teacher, gender: 'asdf').should_not be_valid
    end
  end

  context 'teacher associations' do
    it 'should has many subjects' do
      @teacher = FactoryGirl.create(:teacher)
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      @teacher.subjects << @subject1
      @teacher.subjects << @subject2
      @teacher.subjects.should include @subject1
      @teacher.subjects.should include @subject2
    end

    it 'should not has unincluded subject' do
      @teacher1 = FactoryGirl.create(:teacher)
      @teacher2 = FactoryGirl.create(:teacher)
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      @teacher1.subjects << @subject1
      @teacher2.subjects << @subject2
      @teacher1.subjects.should include @subject1
      @teacher1.subjects.should_not include @subject2
      @teacher2.subjects.should include @subject2
      @teacher2.subjects.should_not include @subject1
    end

    it 'should belongs to school' do
      school = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher, school_id: school.id)
      teacher.school.id.should eq school.id
    end

    it 'should not belong to invalid school' do
      school1 = FactoryGirl.create(:school)
      school2 = FactoryGirl.create(:school)
      teacher = FactoryGirl.create(:teacher, school_id: school1.id)
      teacher.school.id.should eq school1.id
      teacher.school.id.should_not eq school2.id
    end

    it 'should has many classrooms' do
      @teacher = FactoryGirl.create(:teacher)
      @classroom1 = FactoryGirl.create(:classroom)
      @classroom2 = FactoryGirl.create(:classroom)
      @teacher.classrooms << @classroom1
      @teacher.classrooms << @classroom2
      @teacher.classrooms.should include @classroom1
      @teacher.classrooms.should include @classroom2
    end

    it 'should not has unincluded classroom' do
      @teacher1 = FactoryGirl.create(:teacher)
      @teacher2 = FactoryGirl.create(:teacher)
      @classroom1 = FactoryGirl.create(:classroom)
      @classroom2 = FactoryGirl.create(:classroom)
      @teacher1.classrooms << @classroom1
      @teacher2.classrooms << @classroom2
      @teacher1.classrooms.should include @classroom1
      @teacher1.classrooms.should_not include @classroom2
      @teacher2.classrooms.should include @classroom2
      @teacher2.classrooms.should_not include @classroom1
    end
  end
end
