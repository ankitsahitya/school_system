require 'rails_helper'

RSpec.describe Classroom, type: :model do
  before(:each) do
    @school = FactoryGirl.create(:school)
  end
  context 'Classroom validation' do
    it 'should be valid classroom' do
      FactoryGirl.build(:classroom, school_id: @school.id).should be_valid
    end

    it 'should be invalid without a school' do
      FactoryGirl.build(:classroom, school_id: nil).should_not be_valid
    end

    it 'should be invalid without a room number' do
      FactoryGirl.build(:classroom, room_no: nil, school_id: @school.id).should_not be_valid
    end

    it 'should be invalid without a class_no' do
      FactoryGirl.build(:classroom, class_no: nil, school_id: @school.id).should_not be_valid
    end

    it 'should be invalid with a invalid class_no' do
      FactoryGirl.build(:classroom, class_no: Faker::Number.between(12,100), school_id: @school.id).should_not be_valid
    end

    it 'should be invalid with a invalid class_no' do
      FactoryGirl.build(:classroom, class_no: Faker::Name.name, school_id: @school.id).should_not be_valid
    end

    it 'should be invalid with a invalid room_no' do
      FactoryGirl.build(:classroom, room_no: Faker::Name.name, school_id: @school.id).should_not be_valid
    end
  end

  context 'classroom associations' do
    it 'should has many students' do
      @classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      @student1 = FactoryGirl.create(:student, classroom_id: @classroom.id)
      @student2 = FactoryGirl.create(:student, classroom_id: @classroom.id)
      @classroom.students.should include @student1
      @classroom.students.should include @student2
    end

    it 'should not has unincluded students' do
      @classroom1 = FactoryGirl.create(:classroom, school_id: @school.id)
      @classroom2 = FactoryGirl.create(:classroom, school_id: @school.id)
      @student1 = FactoryGirl.create(:student, classroom_id: @classroom1.id)
      @student2 = FactoryGirl.create(:student, classroom_id: @classroom2.id)
      @classroom1.students.should include @student1
      @classroom1.students.should_not include @student2
      @classroom2.students.should include @student2
      @classroom2.students.should_not include @student1
    end

    it 'should has many teachers' do
      @classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      @teacher1 = FactoryGirl.create(:teacher, school_id: @school.id)
      @teacher2 = FactoryGirl.create(:teacher, school_id: @school.id)
      @classroom.teachers << @teacher1
      @classroom.teachers << @teacher2
      @classroom.teachers.should include @teacher1
      @classroom.teachers.should include @teacher2
    end

    it 'should not has unincluded teachers' do
      @classroom1 = FactoryGirl.create(:classroom, school_id: @school.id)
      @classroom2 = FactoryGirl.create(:classroom, school_id: @school.id)
      @teacher1 = FactoryGirl.create(:teacher, school_id: @school.id)
      @teacher2 = FactoryGirl.create(:teacher, school_id: @school.id)
      @classroom1.teachers << @teacher1
      @classroom2.teachers << @teacher2
      @classroom1.teachers.should include @teacher1
      @classroom1.teachers.should_not include @teacher2
      @classroom2.teachers.should include @teacher2
      @classroom2.teachers.should_not include @teacher1
    end

    it 'should belongs to school' do
      school = FactoryGirl.create(:school)
      classroom = FactoryGirl.create(:classroom, school_id: school.id)
      classroom.school.id.should eq school.id
    end

    it 'should not belong to invalid theater' do
      school1 = FactoryGirl.create(:school)
      school2 = FactoryGirl.create(:school)
      classroom = FactoryGirl.create(:classroom, school_id: school1.id)
      classroom.school.id.should eq school1.id
      classroom.school.id.should_not eq school2.id
    end
  end
end
