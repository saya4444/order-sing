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

        # デフォルト値の設定
        after_initialize :set_default_values, if: :new_record?

        private

        def set_default_values
          self.direct_messages_enabled ||= true
        end

end
