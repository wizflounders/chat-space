class Group < ApplicationRecord
  has_many :users, through: :group_users
  has_many :group_users
  accepts_nested_attributes_for :users
  validates :name, presence: true, uniqueness: true

end
