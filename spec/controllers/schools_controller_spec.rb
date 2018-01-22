require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  context 'GET#index' do
    it 'should show all schools successfully' do
      school1 = FactoryGirl.create(:school)
      school2 = FactoryGirl.create(:school)
      get :index, format: 'json'
      assigns(:schools).should include school1
      assigns(:schools).should include school2
      response.should have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'should get school successfully' do
      school = FactoryGirl.create(:school)
      get :show, id: school.id, format: 'json'
      assigns(:school).should eq school
      response.should have_http_status(:ok)
    end

    it 'should not get invalid school' do
      get :show, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new school successfully' do
      get :new, format: 'json'
      assigns(:school).id.should eq nil
      assigns(:school).name.should eq nil
      assigns(:school).address.should eq nil
      assigns(:school).phone_no.should eq nil
      assigns(:school).code.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET#edit' do
    it 'should get correct school successfully' do
      school = FactoryGirl.create(:school)
      get :edit, id: school.id, format: 'json'
      assigns(:school).should eq school
      response.should have_http_status(:ok)
    end

    it 'should not get school with invalid id' do
      get :edit, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create school successfully' do
      post :create, school: { name: 'MMPS', address: '1012 Kristin Underpass', phone_no: '1234567890', code: '3A53F' }, format: 'json'
      assigns(:school).name.should eq 'MMPS'
      assigns(:school).address.should eq '1012 Kristin Underpass'
      assigns(:school).phone_no.should eq '1234567890'
      assigns(:school).code.should eq '3A53F'
      response.should have_http_status(:created)
    end

    it 'should not create school with invalid inputs' do
      post :create, school: { name: nil, address: nil, phone_no: nil, code: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update school successfully' do
      school1 = FactoryGirl.create(:school)
      school2 = FactoryGirl.create(:school)
      put :update, id: school1.id, school: { name: school2.name, address: school2.address, phone_no: school2.phone_no, code: school2.code }, format: 'json'
      assigns(:school).id.should eq school1.id
      assigns(:school).name.should eq school2.name
      assigns(:school).address.should eq school2.address
      assigns(:school).phone_no.should eq school2.phone_no
      assigns(:school).code.should eq school2.code
      response.should have_http_status(:ok)
    end

    it 'should not update school with invalid inputs' do
      school1 = FactoryGirl.create(:school)
      put :update, id: school1.id, school: { name: nil, address: nil, phone_no: nil, code: nil }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update school with invalid school' do
      school2 = FactoryGirl.create(:school)
      put :update, id: Faker::Name.name, school: { name: school2.name, address: school2.address, phone_no: school2.phone_no, code: school2.code }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy school successfully' do
      school = FactoryGirl.create(:school)
      delete :destroy, id: school.id, format: 'json'
      assigns(:school).should eq school
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid school' do
      delete :destroy, id: Faker::Name.name, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
