Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  resources :notices
  get 'admin/category'
  get 'admin/fusers'

  get 'admin/index'
  get 'admin'=>"admin#index" ,:as=> 'admin'
  get 'admin/editmember/:id', to: "admin#editmember", as: 'admin_editmember'
  put 'admin/updatemember/:id', to: "admin#updatemember", as: 'admin_updatemember'
  patch 'admin/updatemember/:id', to: "admin#updatemember"
  delete 'admin/deletemember/:id', to: "admin#deletemember", as: 'admin_deletemember'
  get 'home/index'
  get 'home/temp'

  get 'user/:id',to: "user#index", as: 'user'

  resources :questions do
    resources :answers do
      resources :aevals
    end
    resources :assigns
    resources :hevals
    resources :qevals
  end
  resources :categories do
      resources :questions do
        get :aq
        get :adminaq
        resources :answers
        resources :qevals

      end
  end
  resources :mentorgroups do
    member do
      get :setsuper
      put :updatesuper
      patch :updatesuper
      get :editmember
      put :updatemember
      post :updatemember
      delete :destroymember
      delete :destroysuper
    end
  end
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
