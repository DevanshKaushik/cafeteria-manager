class MenuItem < ActiveRecord::Base
  belongs_to :menu

  def self.breakfast
    all.where(category: "breakfast")
  end

  def self.lunch
    all.where(category: "lunch")
  end

  def self.dinner
    all.where(category: "Dinner")
  end
end
