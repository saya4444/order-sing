Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }

  # ログアウトができなかったため、GETリクエストをdestroy Actionへ渡す
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # ログイン時 トップページを開くとログイン中のユーザーのリスト一覧ページへ
  authenticated :user do
    root 'lists#index', as: :authenticated_root
  end

  # 未ログイン時 トップページを開くとログイン画面へ
  unauthenticated do
    root to: redirect('/users/sign_in'), as: :unauthenticated_root
  end

  resources :lists do
    resources :songs, only: [:create, :destroy, :update, :edit]
    resources :comments, only: [:create, :show]
  end

  resources :users, only: [:show]

  resources :direct_messages, only: [:new, :create, :index, :show]
end
