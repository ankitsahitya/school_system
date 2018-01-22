require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  before(:each) do
    @school = FactoryGirl.create(:school)
  end
  context 'GET#index' do
    it 'should show all classrooms successfully' do
      classroom1 = FactoryGirl.create(:classroom, school_id: @school.id)
      classroom2 = FactoryGirl.create(:classroom, school_id: @school.id)
      get :index, format: 'json'
      assigns(:classrooms).should include classroom1
      assigns(:classrooms).should include classroom2
      response.should have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'should get classroom successfully' do
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      get :show, id: classroom.id, format: 'json'
      assigns(:classroom).should eq classroom
      response.should have_http_status(:ok)
    end

    it 'should not get invalid classroom' do
      get :show, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new classroom successfully' do
      get :new, format: 'json'
      assigns(:classroom).id.should eq nil
      assigns(:classroom).school_id.should eq nil
      assigns(:classroom).room_no.should eq nil
      assigns(:classroom).class_no.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET#edit' do
    it 'should get correct classroom successfully' do
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      get :edit, id: classroom.id, format: 'json'
      assigns(:classroom).should eq classroom
      response.should have_http_status(:ok)
    end

    it 'should not get classroom with invalid id' do
      get :edit, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create classroom successfully' do
      post :create, classroom: { school_id: @school.id, room_no: '123', class_no: '10' }, format: 'json'
      assigns(:classroom).school_id.should eq @school.id
      assigns(:classroom).room_no.should eq 123
      assigns(:classroom).class_no.should eq 10
      response.should have_http_status(:created)
    end

    it 'should not create classroom with invalid inputs' do
      post :create, classroom: { school_id: nil, room_no: nil, class_no: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create classroom with invalid school' do
      post :create, classroom: { school_id: Faker::Name.name, room_no: '123', class_no: '10' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST#add_teacher' do
    it 'should add new teacher for the classroom' do
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      post :add_teacher, id: classroom.id, teacher_id: teacher.id
      response.should have_http_status(:ok)
    end

    it 'should not add enpty teacher for the classroom' do
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      post :add_teacher, id: classroom.id, teacher_id: nil
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not add invalid teacher for the classroom' do
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      teacher = FactoryGirl.create(:teacher, school_id: @school.id)
      post :add_teacher, id: classroom.id, teacher_id: Faker::Name.name
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update classroom successfully' do
      classroom1 = FactoryGirl.create(:classroom, school_id: @school.id)
      classroom2 = FactoryGirl.create(:classroom, school_id: @school.id)
      put :update, id: classroom1.id, classroom: { school_id: classroom2.school_id, room_no: classroom2.room_no, class_no: classroom2.class_no }, format: 'json'
      assigns(:classroom).id.should eq classroom1.id
      assigns(:classroom).school_id.should eq classroom2.school_id
      assigns(:classroom).room_no.should eq classroom2.room_no
      assigns(:classroom).class_no.should eq classroom2.class_no
      response.should have_http_status(:ok)
    end

    it 'should not update classroom with invalid inputs' do
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      put :update, id: classroom.id, classroom: { school_id: nil, room_no: nil, class_no: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update classroom with invalid classroom' do
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      put :update, id: Faker::Name.name, classroom: { school_id: classroom.school_id, room_no: classroom.room_no, class_no: classroom.class_no }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update classroom with invalid school' do
      classroom1 = FactoryGirl.create(:classroom, school_id: @school.id)
      classroom2 = FactoryGirl.create(:classroom, school_id: @school.id)
      post :update, id: classroom1.id, classroom: { school_id: Faker::Name.name, room_no: classroom2.room_no, class_no: classroom2.class_no }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy classroom successfully' do
      classroom = FactoryGirl.create(:classroom, school_id: @school.id)
      delete :destroy, id: classroom.id, format: 'json'
      assigns(:classroom).should eq classroom
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid classroom' do
      delete :destroy, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
