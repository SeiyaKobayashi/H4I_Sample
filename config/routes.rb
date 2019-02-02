Rails.application.routes.draw do
    get '/'             => 'home#top'

    get 'signup'        => 'user#new'
    post 'user/create'  => 'user#create'
    get 'user/:id'      => 'user#show'
    get 'user/:id/edit' => 'user#edit'
    get 'login'         => 'user#login_form'
    post 'login'        => 'user#login'
    post 'logout'       => 'user#logout'

    get 'post/new'      => 'post#new'
    post 'post/create'  => 'post#create'
    get 'post/index'    => 'post#index'
    get 'post/:id/edit' => 'post#edit'
    post 'post/:id/update' => 'post#update'
end
