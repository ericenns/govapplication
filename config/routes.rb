Rails.application.routes.draw do
  devise_for :users 
  
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    delete "/logout" => "devise/sessions#destroy"
    get "/signup" => "devise/registrations#new"
  end
  
  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  
  resources :items,          only: [:create, :edit, :update, :destroy]
end
