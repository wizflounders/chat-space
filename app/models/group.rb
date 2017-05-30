class Group < ApplicationRecord
  has_many :users, through: :group_users
  has_many :group_users
  has_many :messages
  has_many :messaged_users, through: :messages, source: :user

  validates :name, presence: true, uniqueness: true

end
