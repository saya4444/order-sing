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
        validates :password        , format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
        validates :name            , presence: true
        validates :birthdate        , presence: true

        # アソシエーション
        has_many :lists    , dependent: :destroy
        has_many :comments , dependent: :destroy
        has_many :favorites, dependent: :destroy


end
