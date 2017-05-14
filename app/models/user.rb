class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :validatable, password_length: 8..128

  validates :name, presence:  {message: "を入力してください"}, uniqueness: {message: "は既に他のユーザが使用しています"}
  validates :email, presence:  {message: "を入力してください"}, uniqueness: {message: "は既に他のユーザが使用しています"}
end
