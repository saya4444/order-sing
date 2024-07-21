class VocalRange < ActiveHash::Base
  self.data = [
    { id: 1, name: 'ソプラノ' },
    { id: 2, name: 'アルト' },
    { id: 3, name: 'テノール' },
    { id: 4, name: 'バス' }
  ]

  include ActiveHash::Associations
  has_many :users
end

# 音域