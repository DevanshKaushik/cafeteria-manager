class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  def self.create_new_order(user_id)
    new_order = new(
      user_id: user_id,
    )

    if new_order.save
      new_order
    else
      nil
    end
  end

  def self.current_order(user_id)
    current_order = all.find_by(user_id: user_id, date: nil)

    unless current_order
      return create_new_order(user_id)
    end

    current_order
  end
end
