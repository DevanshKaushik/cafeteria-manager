class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item

  def self.total_price
    all.map { |item| item.menu_item_price }.sum
  end
end
