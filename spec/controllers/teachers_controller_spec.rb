require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  context 'GET#index' do
    it 'should show all teachers successfully' do
      teacher1 = FactoryGirl.create(:teacher)
      teacher2 = FactoryGirl.create(:teacher)
      get :index, format: 'json'
      assigns(:teachers).should include teacher1
      assigns(:teachers).should include teacher2
      response.should have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'should get teacher successfully' do
      teacher = FactoryGirl.create(:teacher)
      get :show, id: teacher.id, format: 'json'
      assigns(:teacher).should eq teacher
      response.should have_http_status(:ok)
    end

    it 'should not get invalid teacher' do
      get :show, id: '12345', format: 'json'
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
      teacher = FactoryGirl.create(:teacher)
      get :edit, id: teacher.id, format: 'json'
      assigns(:teacher).should eq teacher
      response.should have_http_status(:ok)
    end

    it 'should not get teacher with invalid id' do
      get :edit, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create teacher successfully' do
      teacher = FactoryGirl.create(:teacher)
      post :create, teacher: { name: teacher.name, address: teacher.address, phone_no: teacher.phone_no, gender: teacher.gender, school_id: teacher.school_id }, format: 'json'
      assigns(:teacher).school_id.should eq teacher.school_id
      assigns(:teacher).name.should eq teacher.name
      assigns(:teacher).address.should eq teacher.address
      assigns(:teacher).phone_no.should eq teacher.phone_no
      assigns(:teacher).gender.should eq teacher.gender
      response.should have_http_status(:created)
    end

    it 'should not create teacher with invalid inputs' do
      post :create, teacher: { name: nil, address: nil, phone_no: nil, gender: nil, school_id: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create teacher with invalid school' do
      teacher = FactoryGirl.create(:teacher)
      post :create, teacher: { name: teacher.name, address: teacher.address, phone_no: teacher.phone_no, gender: teacher.gender, school_id: '1234' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST#add_subject' do
    it 'should add new subject for the teacher' do
      teacher = FactoryGirl.create(:teacher)
      subject = FactoryGirl.create(:subject)
      post :add_subject, id: teacher.id, subject_id: subject.id
      response.should have_http_status(:ok)
    end

    it 'should add empty subject for the teacher' do
      teacher = FactoryGirl.create(:teacher)
      subject = FactoryGirl.create(:subject)
      post :add_subject, id: teacher.id, subject_id: nil
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should add invalid subject for the teacher' do
      teacher = FactoryGirl.create(:teacher)
      subject = FactoryGirl.create(:subject)
      post :add_subject, id: teacher.id, subject_id: '1234567'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST#add_classroom' do
    it 'should add new classroom for the teacher' do
      teacher = FactoryGirl.create(:teacher)
      classroom = FactoryGirl.create(:classroom)
      post :add_classroom, id: teacher.id, classroom_id: classroom.id
      response.should have_http_status(:ok)
    end

    it 'should add empty classroom for the teacher' do
      teacher = FactoryGirl.create(:teacher)
      classroom = FactoryGirl.create(:classroom)
      post :add_classroom, id: teacher.id, classroom_id: nil
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should add invalid classroom for the teacher' do
      teacher = FactoryGirl.create(:teacher)
      classroom = FactoryGirl.create(:classroom)
      post :add_classroom, id: teacher.id, classroom_id: '12345678'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update teacher successfully' do
      teacher1 = FactoryGirl.create(:teacher)
      teacher2 = FactoryGirl.create(:teacher)
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
      teacher1 = FactoryGirl.create(:teacher)
      put :update, id: teacher1.id, teacher: { name: nil, address: nil, phone_no: nil, gender: nil, school_id: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update teacher with invalid school' do
      teacher1 = FactoryGirl.create(:teacher)
      teacher2 = FactoryGirl.create(:teacher)
      post :update, id: teacher1.id, teacher: { name: teacher2.name, address: teacher2.address, phone_no: teacher2.phone_no, gender: teacher2.gender, school_id: '12345' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update teacher with invalid teacher' do
      teacher2 = FactoryGirl.create(:teacher)
      put :update, id: '123456', teacher: { name: teacher2.name, address: teacher2.address, phone_no: teacher2.phone_no, gender: teacher2.gender, school_id: teacher2.school_id }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy teacher successfully' do
      teacher = FactoryGirl.create(:teacher)
      delete :destroy, id: teacher.id, format: 'json'
      assigns(:teacher).should eq teacher
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid teacher' do
      delete :destroy, id: '12345', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
