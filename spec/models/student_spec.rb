require 'rails_helper'

RSpec.describe Student, type: :model do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @classroom = FactoryGirl.create(:classroom, school_id: @school.id)
  end
  context 'student validation' do
    it 'should be valid student' do
      FactoryGirl.build(:student, classroom_id: @classroom.id).should be_valid
    end

    it 'should be invalid without a classroom' do
      FactoryGirl.build(:student, classroom_id: nil).should_not be_valid
    end

    it 'should be invalid without a name' do
      FactoryGirl.build(:student, name: nil, classroom_id: @classroom.id).should_not be_valid
    end

    it 'should be invalid without a address' do
      FactoryGirl.build(:student, address: nil, classroom_id: @classroom.id).should_not be_valid
    end

    it 'should be invalid without a phone_no' do
      FactoryGirl.build(:student, phone_no: nil, classroom_id: @classroom.id).should_not be_valid
    end

    it 'should be invalid without a gender' do
      FactoryGirl.build(:student, gender: nil, classroom_id: @classroom.id).should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:student, phone_no: Faker::Number.number(6), classroom_id: @classroom.id).should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:student, phone_no: Faker::Name.name, classroom_id: @classroom.id).should_not be_valid
    end

    it 'should be invalid with a invalid phone_no' do
      FactoryGirl.build(:student, phone_no: Faker::Number.number(18), classroom_id: @classroom.id).should_not be_valid
    end

    it 'should be invalid with a invalid gender' do
      FactoryGirl.build(:student, gender: Faker::Name.name, classroom_id: @classroom.id).should_not be_valid
    end
  end

  context 'student associations' do
    it 'should has many subjects' do
      @student = FactoryGirl.create(:student, classroom_id: @classroom.id)
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      @student.subjects << @subject1
      @student.subjects << @subject2
      @student.subjects.should include @subject1
      @student.subjects.should include @subject2
    end

    it 'should not has unincluded subject' do
      @student1 = FactoryGirl.create(:student, classroom_id: @classroom.id)
      @student2 = FactoryGirl.create(:student, classroom_id: @classroom.id)
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      @student1.subjects << @subject1
      @student2.subjects << @subject2
      @student1.subjects.should include @subject1
      @student1.subjects.should_not include @subject2
      @student2.subjects.should include @subject2
      @student2.subjects.should_not include @subject1
    end

    it 'should belongs to classroom' do
      school = FactoryGirl.create(:school)
      classroom = FactoryGirl.create(:classroom, school_id: school.id)
      student = FactoryGirl.create(:student, classroom_id: classroom.id)
      student.classroom.id.should eq classroom.id
    end

    it 'should not belong to invalid classroom' do
      school = FactoryGirl.create(:school)
      classroom1 = FactoryGirl.create(:classroom, school_id: school.id)
      classroom2 = FactoryGirl.create(:classroom, school_id: school.id)
      student = FactoryGirl.create(:student, classroom_id: classroom1.id)
      student.classroom.id.should eq classroom1.id
      student.classroom.id.should_not eq classroom2.id
    end
  end
end
