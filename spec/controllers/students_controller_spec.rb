require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  context 'GET#index' do
    it 'should show all students successfully' do
      student1 = FactoryGirl.create(:student)
      student2 = FactoryGirl.create(:student)
      get :index, format: 'json'
      assigns(:students).should include student1
      assigns(:students).should include student2
      response.should have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'should get student successfully' do
      student = FactoryGirl.create(:student)
      get :show, id: student.id, format: 'json'
      assigns(:student).should eq student
      response.should have_http_status(:ok)
    end

    it 'should not get invalid student' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new student successfully' do
      get :new, format: 'json'
      assigns(:student).id.should eq nil
      assigns(:student).school_id.should eq nil
      assigns(:student).classroom_id.should eq nil
      assigns(:student).name.should eq nil
      assigns(:student).address.should eq nil
      assigns(:student).phone_no.should eq nil
      assigns(:student).gender.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET#edit' do
    it 'should get correct student successfully' do
      student = FactoryGirl.create(:student)
      get :edit, id: student.id, format: 'json'
      assigns(:student).should eq student
      response.should have_http_status(:ok)
    end

    it 'should not get student with invalid id' do
      get :edit, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create student successfully' do
      student = FactoryGirl.create(:student)
      post :create, student: { name: student.name, address: student.address, phone_no: student.phone_no, gender: student.gender, school_id: student.school_id, classroom_id: student.classroom_id }, format: 'json'
      assigns(:student).school_id.should eq student.school_id
      assigns(:student).classroom_id.should eq student.classroom_id
      assigns(:student).name.should eq student.name
      assigns(:student).address.should eq student.address
      assigns(:student).phone_no.should eq student.phone_no
      assigns(:student).gender.should eq student.gender
      response.should have_http_status(:created)
    end

    it 'should not create student with invalid inputs' do
      post :create, student: { name: nil, address: nil, phone_no: nil, gender: nil, school_id: nil, classroom_id: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create student with invalid school' do
      student = FactoryGirl.create(:student)
      post :create, student: { name: student.name, address: student.address, phone_no: student.phone_no, gender: student.gender, school_id: '1234', classroom_id: student.classroom_id }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create student with invalid classroom' do
      student = FactoryGirl.create(:student)
      post :create, student: { name: student.name, address: student.address, phone_no: student.phone_no, gender: student.gender, school_id: student.school_id, classroom_id: '123456' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST#add_subject' do
    it 'should add new subject for the student' do
      student = FactoryGirl.create(:student)
      subject = FactoryGirl.create(:subject)
      post :add_subject, id: student.id, subject_id: subject.id
      response.should have_http_status(:ok)
    end

    it 'should not add enpty subject for the student' do
      student = FactoryGirl.create(:student)
      subject = FactoryGirl.create(:subject)
      post :add_subject, id: student.id, subject_id: nil
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not add invalid subject for the student' do
      student = FactoryGirl.create(:student)
      subject = FactoryGirl.create(:subject)
      post :add_subject, id: student.id, subject_id: '123456'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update student successfully' do
      student1 = FactoryGirl.create(:student)
      student2 = FactoryGirl.create(:student)
      put :update, id: student1.id, student: { name: student2.name, address: student2.address, phone_no: student2.phone_no, gender: student2.gender, school_id: student2.school_id, classroom_id: student2.classroom_id }, format: 'json'
      assigns(:student).id.should eq student1.id
      assigns(:student).school_id.should eq student2.school_id
      assigns(:student).classroom_id.should eq student2.classroom_id
      assigns(:student).name.should eq student2.name
      assigns(:student).address.should eq student2.address
      assigns(:student).phone_no.should eq student2.phone_no
      assigns(:student).gender.should eq student2.gender
      response.should have_http_status(:ok)
    end

    it 'should not update student with invalid inputs' do
      student1 = FactoryGirl.create(:student)
      put :update, id: student1.id, student: { name: nil, address: nil, phone_no: nil, gender: nil, school_id: nil, classroom_id: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update student with invalid school' do
      student1 = FactoryGirl.create(:student)
      student2 = FactoryGirl.create(:student)
      post :update, id: student1.id, student: { name: student2.name, address: student2.address, phone_no: student2.phone_no, gender: student2.gender, school_id: '12345', classroom_id: student2.classroom_id }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update student with invalid classroom' do
      student1 = FactoryGirl.create(:student)
      student2 = FactoryGirl.create(:student)
      post :update, id: student1.id, student: { name: student2.name, address: student2.address, phone_no: student2.phone_no, gender: student2.gender, school_id: student2.school_id, classroom_id: '123' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update student with invalid student' do
      student2 = FactoryGirl.create(:student)
      put :update, id: '123456', student: { name: student2.name, address: student2.address, phone_no: student2.phone_no, gender: student2.gender, school_id: student2.school_id, classroom_id: student2.classroom_id }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy student successfully' do
      student = FactoryGirl.create(:student)
      delete :destroy, id: student.id, format: 'json'
      assigns(:student).should eq student
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid student' do
      delete :destroy, id: '12345', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
