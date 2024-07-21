class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :authenticate_user!, only: [:edit, :update]

  def edit
  end

  def update
    @user = current_user

    if @user.update_with_password(password_update_params)
      bypass_sign_in(@user)
      redirect_to root_path, notice: 'パスワードが更新されました。'
    else
      render :edit
    end
  end

  private

  def password_update_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
