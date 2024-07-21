# spec/requests/user_sessions_spec.rb
require 'rails_helper'

RSpec.describe 'ユーザーログイン/ログアウト/編集', type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'ログイン機能' do
    it 'ログインページが表示されること' do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end

    it '有効なユーザーでログインできること' do
      post user_session_path, params: { user: { email: @user.email, password: @user.password } }
      expect(response).to redirect_to(authenticated_root_path)
    end

    it '無効なユーザーでログインできないこと' do
      post user_session_path, params: { user: { email: @user.email, password: 'invalidpassword' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'ログアウト機能' do
    it 'ログアウトできること' do
      sign_in @user
      delete destroy_user_session_path
      expect(response).to redirect_to(unauthenticated_root_path)
    end
  end

  describe 'ユーザー情報の更新' do
    it '有効な情報でユーザー情報を更新できること' do
      sign_in @user
      patch user_registration_path, params: { user: { name: 'New Name', email: 'new@example.com', current_password: @user.password } }
      expect(response).to redirect_to(authenticated_root_path)
    end

    it '無効な情報で更新できないこと' do
      sign_in @user
      patch user_registration_path, params: { user: { email: '', current_password: @user.password } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it '無効なパスワードでパスワード変更できないこと' do
      sign_in @user
      patch user_registration_path, params: { user: { current_password: @user.password, password: 'short', password_confirmation: 'short' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end
end
