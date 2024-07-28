class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Active Storageの設定
  has_one_attached :image

  # ActiveHashの設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :vocal_range, class_name: 'VocalRange', optional: true

  # バリデーション
  validate :password_must_include_both_letters_and_numbers
  validate :password_cannot_include_full_width_characters
  validates :name, presence: true
  validates :birthdate, presence: true

  def password_must_include_both_letters_and_numbers
    if password.present? && (!password.match?(/[a-zA-Z]/) || !password.match?(/\d/))
      errors.add :password, "は英字と数字の両方を含む必要があります"
    end
  end

  def password_cannot_include_full_width_characters
    if password.present? && password.match?(/[ぁ-んァ-ン々〆〤]/)
      errors.add :password, "は全角文字を含むことはできません"
    end
  end

  # アソシエーション
  has_many :lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :sent_direct_messages    , class_name: 'DirectMessage', foreign_key: 'sender_id'   , dependent: :destroy
  has_many :received_direct_messages, class_name: 'DirectMessage', foreign_key: 'recipient_id', dependent: :destroy

  # デフォルト値の設定
  after_initialize :set_default_values, if: :new_record?

  private

  def set_default_values
    self.direct_messages_enabled ||= true
  end
end
