require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  context 'GET#index' do
    it 'should show all subjects successfully' do
      subject1 = FactoryGirl.create(:subject)
      subject2 = FactoryGirl.create(:subject)
      get :index, format: 'json'
      assigns(:subjects).should include subject1
      assigns(:subjects).should include subject2
      response.should have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'should get subject successfully' do
      subject = FactoryGirl.create(:subject)
      get :show, id: subject.id, format: 'json'
      assigns(:subject).should eq subject
      response.should have_http_status(:ok)
    end

    it 'should not get invalid subject' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new subject successfully' do
      get :new, format: 'json'
      assigns(:subject).id.should eq nil
      assigns(:subject).name.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET#edit' do
    it 'should get correct subject successfully' do
      subject = FactoryGirl.create(:subject)
      get :edit, id: subject.id, format: 'json'
      assigns(:subject).should eq subject
      response.should have_http_status(:ok)
    end

    it 'should not get subject with invalid id' do
      get :edit, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create subject successfully' do
      subject = FactoryGirl.create(:subject)
      post :create, subject: { name: subject.name }, format: 'json'
      assigns(:subject).name.should eq subject.name
      response.should have_http_status(:created)
    end

    it 'should not create subject with invalid inputs' do
      post :create, subject: { name: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST#add_teacher' do
    it 'should add new teacher for the subject' do
      subject = FactoryGirl.create(:subject)
      teacher = FactoryGirl.create(:teacher)
      post :add_teacher, id: subject.id, teacher_id: teacher.id
      response.should have_http_status(:ok)
    end

    it 'should add empty teacher for the subject' do
      subject = FactoryGirl.create(:subject)
      teacher = FactoryGirl.create(:teacher)
      post :add_teacher, id: subject.id, teacher_id: nil
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should add invalid teacher for the subject' do
      subject = FactoryGirl.create(:subject)
      teacher = FactoryGirl.create(:teacher)
      post :add_teacher, id: subject.id, teacher_id: '123456'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST#add_student' do
    it 'should add new student for the subject' do
      subject = FactoryGirl.create(:subject)
      student = FactoryGirl.create(:student)
      post :add_student, id: subject.id, student_id: student.id
      response.should have_http_status(:ok)
    end

    it 'should add empty student for the subject' do
      subject = FactoryGirl.create(:subject)
      student = FactoryGirl.create(:student)
      post :add_student, id: subject.id, student_id: nil
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should add invalid student for the subject' do
      subject = FactoryGirl.create(:subject)
      student = FactoryGirl.create(:student)
      post :add_student, id: subject.id, student_id: '123456'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update subject successfully' do
      subject1 = FactoryGirl.create(:subject)
      subject2 = FactoryGirl.create(:subject)
      put :update, id: subject1.id, subject: { name: subject2.name }, format: 'json'
      assigns(:subject).id.should eq subject1.id
      assigns(:subject).name.should eq subject2.name
      response.should have_http_status(:ok)
    end

    it 'should not update subject with invalid inputs' do
      subject1 = FactoryGirl.create(:subject)
      put :update, id: subject1.id, subject: { name: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update subject with invalid category' do
      subject2 = FactoryGirl.create(:subject)
      put :update, id: '123456', subject: { name: subject2.name }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy subject successfully' do
      subject = FactoryGirl.create(:subject)
      delete :destroy, id: subject.id, format: 'json'
      assigns(:subject).should eq subject
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid subject' do
      delete :destroy, id: '12345', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
