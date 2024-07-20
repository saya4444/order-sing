Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # ログイン時 トップページを開くとログイン中のユーザーのリスト一覧ページへ
  authenticated :user do
    root 'lists#index', as: :authenticated_root
  end

  # 未ログイン時 トップページを開くとログイン画面へ
  unauthenticated do
    root to: redirect('/users/sign_in'), as: :unauthenticated_root
  end

  resources :lists


end
