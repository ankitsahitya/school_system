require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  before(:each) do
    @school = FactoryGirl.create(:school)
  end
  context 'GET#index' do
    it 'should show all teachers successfully' do
      teacher1 = FactoryGirl.create(:teacher, school_id: @school.id)
      teacher2 = FactoryGirl.create(:teacher, school_id: @school.id)
      get :index, format: 'json'
      assigns(:teachers).should include teacher1
      assigns(:teachers).should include teacher2
      response.should have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'should get teacher successfully' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      get :show, id: teacher.id, format: 'json'
      assigns(:teacher).should eq teacher
      response.should have_http_status(:ok)
    end

    it 'should not get invalid teacher' do
      get :show, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new teacher successfully' do
      get :new, format: 'json'
      assigns(:teacher).id.should eq nil
      assigns(:teacher).school_id.should eq nil
      assigns(:teacher).name.should eq nil
      assigns(:teacher).address.should eq nil
      assigns(:teacher).phone_no.should eq nil
      assigns(:teacher).gender.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET#edit' do
    it 'should get correct teacher successfully' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      get :edit, id: teacher.id, format: 'json'
      assigns(:teacher).should eq teacher
      response.should have_http_status(:ok)
    end

    it 'should not get teacher with invalid id' do
      get :edit, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create teacher successfully' do
      post :create, teacher: { name: 'Ankit', address: '1012 Kristin Underpass', phone_no: '9764583291', gender: 'male', school_id: @school.id }, format: 'json'
      assigns(:teacher).school_id.should eq @school.id
      assigns(:teacher).name.should eq 'Ankit'
      assigns(:teacher).address.should eq '1012 Kristin Underpass'
      assigns(:teacher).phone_no.should eq '9764583291'
      assigns(:teacher).gender.should eq 'male'
      response.should have_http_status(:created)
    end

    it 'should not create teacher with invalid inputs' do
      post :create, teacher: { name: nil, address: nil, phone_no: nil, gender: nil, school_id: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create teacher with invalid school' do
      post :create, teacher: { name: 'Ankit', address: '1012 Kristin Underpass', phone_no: '9764583291', gender: 'male', school_id: Faker::Name.name }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST#add_subject' do
    it 'should add new subject for the teacher' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      subject = FactoryGirl.create(:subject)
      post :add_subject, id: teacher.id, subject_id: subject.id
      response.should have_http_status(:ok)
    end

    it 'should add empty subject for the teacher' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      post :add_subject, id: teacher.id, subject_id: nil
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should add invalid subject for the teacher' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      post :add_subject, id: teacher.id, subject_id: Faker::Name.name
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST#add_classroom' do
    it 'should add new classroom for the teacher' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      post :add_classroom, id: teacher.id, classroom_id: classroom.id
      response.should have_http_status(:ok)
    end

    it 'should add empty classroom for the teacher' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      post :add_classroom, id: teacher.id, classroom_id: nil
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should add invalid classroom for the teacher' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      post :add_classroom, id: teacher.id, classroom_id: Faker::Name.name
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update teacher successfully' do
      teacher1 = FactoryGirl.create(:teacher, school_id: @school.id)
      teacher2 = FactoryGirl.create(:teacher, school_id: @school.id)
      put :update, id: teacher1.id, teacher: { name: teacher2.name, address: teacher2.address, phone_no: teacher2.phone_no, gender: teacher2.gender, school_id: teacher2.school_id }, format: 'json'
      assigns(:teacher).id.should eq teacher1.id
      assigns(:teacher).school_id.should eq teacher2.school_id
      assigns(:teacher).name.should eq teacher2.name
      assigns(:teacher).address.should eq teacher2.address
      assigns(:teacher).phone_no.should eq teacher2.phone_no
      assigns(:teacher).gender.should eq teacher2.gender
      response.should have_http_status(:ok)
    end

    it 'should not update teacher with invalid inputs' do
      teacher1 = FactoryGirl.create(:teacher, school_id: @school.id)
      put :update, id: teacher1.id, teacher: { name: nil, address: nil, phone_no: nil, gender: nil, school_id: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update teacher with invalid school' do
      teacher1 = FactoryGirl.create(:teacher, school_id: @school.id)
      teacher2 = FactoryGirl.create(:teacher, school_id: @school.id)
      post :update, id: teacher1.id, teacher: { name: teacher2.name, address: teacher2.address, phone_no: teacher2.phone_no, gender: teacher2.gender, school_id: Faker::Name.name }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update teacher with invalid teacher' do
      teacher2 = FactoryGirl.create(:teacher, school_id: @school.id)
      put :update, id: Faker::Name.name, teacher: { name: teacher2.name, address: teacher2.address, phone_no: teacher2.phone_no, gender: teacher2.gender, school_id: teacher2.school_id }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy teacher successfully' do
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      delete :destroy, id: teacher.id, format: 'json'
      assigns(:teacher).should eq teacher
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid teacher' do
      delete :destroy, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
