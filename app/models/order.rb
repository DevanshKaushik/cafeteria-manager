class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  def self.current_order(user_id)
    current_order = all.find_by(user_id: user_id, date: nil)
    unless current_order
      new_order = new(
        user_id: user_id,
        date: nil,
        delivered_at: nil,
      )

      if new_order.save
        return [new_order, nil]
      else
        return [nil, "There was some error processing your request. Please retry."]
      end
    end
    [current_order, nil]
  end
end
