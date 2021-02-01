class MenuItem < ActiveRecord::Base
  has_many :order_items
  belongs_to :menu

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
