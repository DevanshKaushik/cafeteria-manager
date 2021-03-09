class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true

  def self.clerks
    all.where(role: "clerk")
  end

  def self.not_owner
    all.where.not(role: "owner")
  end
end
