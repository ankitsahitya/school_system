require 'rails_helper'

RSpec.describe School, type: :model do
  context 'school validation' do
    it 'should valid school' do
      FactoryGirl.build(:school).should be_valid
    end

    it 'should invalid without a name' do
      FactoryGirl.build(:school, name: nil).should_not be_valid
    end

    it 'should invalid without a address' do
      FactoryGirl.build(:school, address: nil).should_not be_valid
    end

    it 'should invalid without a phone_no' do
      FactoryGirl.build(:school, phone_no: nil).should_not be_valid
    end

    it 'should invalid without a code' do
      FactoryGirl.build(:school, code: nil).should_not be_valid
    end

    it 'should invalid with short phone_no' do
      FactoryGirl.build(:school, phone_no: '7982317').should_not be_valid
    end

    it 'should invalid with long phone_no' do
      FactoryGirl.build(:school, phone_no: '8978237874794734797288799').should_not be_valid
    end

    it 'should invalid with invalid phone_no' do
      FactoryGirl.build(:school, phone_no: 'asdfg').should_not be_valid
    end
  end

  context 'school associations' do
    it 'should has many classrooms' do
      @school = FactoryGirl.create(:school)
      @classroom1 = FactoryGirl.create(:classroom, school_id: @school.id)
      @classroom2 = FactoryGirl.create(:classroom, school_id: @school.id)
      @school.classrooms.should include @classroom1
      @school.classrooms.should include @classroom2
    end

    it 'should not has unincluded classrooms' do
      @school1 = FactoryGirl.create(:school)
      @school2 = FactoryGirl.create(:school)
      @classroom1 = FactoryGirl.create(:classroom, school_id: @school1.id)
      @classroom2 = FactoryGirl.create(:classroom, school_id: @school2.id)
      @school1.classrooms.should include @classroom1
      @school1.classrooms.should_not include @classroom2
      @school2.classrooms.should include @classroom2
      @school2.classrooms.should_not include @classroom1
    end

    it 'should has many teachers' do
      @school = FactoryGirl.create(:school)
      @teacher1 = FactoryGirl.create(:teacher, school_id: @school.id)
      @teacher2 = FactoryGirl.create(:teacher, school_id: @school.id)
      @school.teachers.should include @teacher1
      @school.teachers.should include @teacher2
    end

    it 'should not has unincluded teachers' do
      @school1 = FactoryGirl.create(:school)
      @teacher1 = FactoryGirl.create(:teacher, school_id: @school1.id)
      @school2 = FactoryGirl.create(:school)
      @teacher2 = FactoryGirl.create(:teacher, school_id: @school2.id)
      @school1.teachers.should include @teacher1
      @school1.teachers.should_not include @teacher2
      @school2.teachers.should include @teacher2
      @school2.teachers.should_not include @teacher1
    end

    it 'should has many students' do
      @school = FactoryGirl.create(:school)
      @student1 = FactoryGirl.create(:student, school_id: @school.id)
      @student2 = FactoryGirl.create(:student, school_id: @school.id)
      @school.students.should include @student1
      @school.students.should include @student2
    end

    it 'should not has unincluded teachers' do
      @school1 = FactoryGirl.create(:school)
      @student1 = FactoryGirl.create(:student, school_id: @school1.id)
      @school2 = FactoryGirl.create(:school)
      @student2 = FactoryGirl.create(:student, school_id: @school2.id)
      @school1.students.should include @student1
      @school1.students.should_not include @student2
      @school2.students.should include @student2
      @school2.students.should_not include @student1
    end
  end
end
