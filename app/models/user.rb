class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


        belongs_to :vocal_range, class_name: 'VocalRange', optional: true


        validates :password        , format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
        validates :name            , presence: true
        validates :birthday        , presence: true


        has_many :lists    , dependent: :destroy
        has_many :comments , dependent: :destroy
        has_many :favorites, dependent: :destroy



end
