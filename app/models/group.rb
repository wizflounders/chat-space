class Group < ApplicationRecord
  has_many :users, through: :group_users
  has_many :group_users
  accepts_nested_attributes_for :users
  validates :name, presence:  {message: "を入力してください"},uniqueness: {message: "は既に使用してされています"}

end
