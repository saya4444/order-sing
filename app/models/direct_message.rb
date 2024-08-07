# app/models/direct_message.rb
class DirectMessage < ApplicationRecord
  belongs_to :sender   , class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates  :body     , presence: true
end