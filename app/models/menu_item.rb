class MenuItem < ActiveRecord::Base
  has_many :order_items
  belongs_to :menu

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :name, length: { minimum: 5 }

  def self.breakfast
    all.where(category: "Breakfast")
  end

  def self.lunch
    all.where(category: "Lunch")
  end

  def self.dinner
    all.where(category: "Dinner")
  end
end
