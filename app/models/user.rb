class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  def self.clerks
    all.where(role: "clerk")
  end

  def self.not_owner
    all.where.not(role: "owner")
  end
end
