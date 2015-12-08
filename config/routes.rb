Rails.application.routes.draw do
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get    'passwd'=> 'sessions#passwd'
  post   'passwd'=> 'sessions#reset_passwd'
  delete 'logout'  => 'sessions#destroy'

  resources :users

  get '/users/:id/new_application' => 'users#new_application', :as => :new_application
  get '/users/:id/edit_ta_application' => 'users#edit_ta_application', :as => :edit_ta_application
  patch '/users/:id/update_ta_application' => 'users#update_ta_application', :as => :update_ta_application
  post '/users/:id/create_ta_application' => 'users#create_ta_application', :as => :create_ta_application
  get '/users/:id/withdraw_application' => 'users#withdraw_student_application', :as => :withdraw_student_application

  get '/users/:id/accept_assignment' => 'users#accept_ta_assignment', :as => :accept_ta_assignment
  get '/users/:id/reject_assignment' => 'users#reject_ta_assignment', :as => :reject_ta_assignment

  get '/users/:id/edit_suggestion' => 'users#edit_suggestion', :as => :edit_suggestion
  get '/users/:id/submit_ta_suggestion' => 'users#submit_ta_suggestion', :as => :submit_ta_suggestion
  get '/users/(:id)/lecturer_show' => 'users#lecturer_show', :as => :lecturer_show
  get '/users/:id/delete_suggestion' => 'users#delete_suggestion', :as => :delete_suggestion

  
  get '/users/modify/uploadusers' => 'users#uploadusers', :as => :uploadusers
  get '/users/modify/process_user_import' => 'users#process_user_import', :as => :process_user_import

  post '/users/modify/email_user' => 'users#email_user', :as => :email_user, :action => :email_user

  root 'static_pages#home'
  get 'error' => 'static_pages#error'

  get ({'help' => 'static_pages#help'})

  get ({'contact' => 'static_pages#contact'})
  
  #resources :students  
  #get '/students/(:id)/withdraw_application' => 'students#withdraw_application', :as => :withdraw_application
  #get '/students/(:id)/accept_assignment' => 'students#accept_assignment', :as => :accept_assignment
  #get '/students/(:id)/reject_assignment' => 'students#reject_assignment', :as => :reject_assignment
  #resources :student_applications
  get 'student_applications' => 'student_applications#index'
  # get '/student_applications/(:id)/withdraw_application' => 'student_applications#withdraw_application', :as => :withdraw_application
  # get '/student_applications/(:id)/accept_assignment' => 'student_applications#accept_assignment', :as => :accept_assignment
  # get '/student_applications/(:id)/reject_assignment' => 'student_applications#reject_assignment', :as => :reject_assignment
  
  resources :courses

  get '/courses/(:id)/select_new_ta' => 'courses#select_new_ta', :as => :select_new_ta
  get '/courses/(:id)/assign_new_ta' => 'courses#assign_new_ta', :as => :assign_new_ta

  get '/courses/(:id)/delete_ta' => 'courses#delete_ta', :as => :delete_ta, :action => :delete_ta
  post '/courses/(:id)/email_ta_notification' => 'courses#email_ta_notification', :as => :email_ta_notification, :action => :email_ta_notification
  get '/courses/(:id)/confirm_ta' => 'courses#confirm_ta', :as => :confirm_ta, :action => :confirm_ta
  get '/courses/modify/drop_all' => 'courses#drop_all', :as => :drop_all, :action => :drop_all
  
  get '/courses/modify/upload/' => 'courses#upload', :as => :upload, :action => :upload
  get '/courses/modify/process_course_import' => 'courses#process_course_import', :as => :process_course_import, :action => :process_course_import
  
  resources :application_pools
  #root :to => redirect('/students')
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
