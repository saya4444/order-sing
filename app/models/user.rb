class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        # Active Storageの設定
        has_one_attached :image

        # ActiveHashの設定
        belongs_to :vocal_range, class_name: 'VocalRange', optional: true

        # バリデーション
        validates :name             , presence: true
        validates :birthdate        , presence: true

        # アソシエーション
        has_many :lists    , dependent: :destroy
        has_many :comments , dependent: :destroy
        has_many :favorites, dependent: :destroy

        # パスワードなしで編集可能
        def update_without_password(params, *options)
          params.delete(:current_password)
          if params[:password].blank?
            params.delete(:password)
            params.delete(:password_confirmation)
          end
          result = update(params, *options)
          clean_up_passwords
          result
        end


end
