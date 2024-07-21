class Key < ActiveHash::Base
  self.data = [
    { id:  1, name: '+6' },
    { id:  2, name: '+5' },
    { id:  3, name: '+4' },
    { id:  4, name: '+3' },
    { id:  5, name: '+2' },
    { id:  6, name: '+1' },
    { id:  7, name: '0'  },
    { id:  8, name: '-1' },
    { id:  9, name: '-2' },
    { id: 10, name: '-3' },
    { id: 11, name: '-4' },
    { id: 12, name: '-5' },
    { id: 13, name: '-6' }
  ]

  include ActiveHash::Associations
  has_many :lists
end

#キー設定