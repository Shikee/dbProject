Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :notices
  get 'admin/category'

  get 'admin/index'
  get 'admin'=>"admin#index" ,:as=> 'admin'

  post '/rate' => 'rater#create', :as => 'rate'
  get 'home/index'
  get 'home/temp'

  resources :questions do
    resources :answers
    resources :hevals

  end
  resources :categories do
      resources :questions do
        resources :answers
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
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
