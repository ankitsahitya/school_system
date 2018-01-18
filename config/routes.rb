Rails.application.routes.draw do
  resources :schools
  post '/classrooms/:id/add_teacher', to: 'classrooms#add_teacher'
  resources :classrooms
  post '/teachers/:id/add_subject', to: 'teachers#add_subject'
  post '/teachers/:id/add_classroom', to: 'teachers#add_classroom'
  resources :teachers
  post '/subjects/:id/add_teacher', to: 'subjects#add_teacher'
  post '/subjects/:id/add_student', to: 'subjects#add_student'
  resources :subjects
  post '/students/:id/add_subject', to: 'students#add_subject'
  resources :students
end
