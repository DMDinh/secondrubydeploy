class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :myposts, through: :likes, source: :post

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :lname, length: {minimum: 2}, presence: true
  validates :fname, length: {minimum: 2}, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: {minimum: 8}, presence: true


  before_save do
    self.email.downcase!
    self.fname.downcase!
    self.lname.downcase!
    self.password.downcase!
  end
end
