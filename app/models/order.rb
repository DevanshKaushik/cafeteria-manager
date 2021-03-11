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

  def self.active_orders
    all.where.not(date: nil)
  end

  def self.pending_orders
    all.active_orders.where(delivered_at: nil)
  end

  def self.delivered_orders
    all.where.not(delivered_at: nil)
  end

  def self.walkin_orders
    user_ids = User.all.where("role = 'clerk' OR role = 'owner'").map { |user| user.id }.join(", ")
    all.active_orders.where("user_id IN (#{user_ids})").order("date DESC")
  end

  def self.today_revenue
    today_order.map { |order| order.order_items.total_price }.sum
  end

  def self.today_order
    all.active_orders.where("date BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end

  def self.max_orders
    orders = today_order
    max_orders = 0

    (0..14).to_a.each do |index|
      total_orders = where("date BETWEEN ? AND ?", DateTime.now.beginning_of_day - index, DateTime.now.end_of_day - index)
      if total_orders.count > max_orders
        max_orders = total_orders.count
        orders = total_orders
      end
    end

    orders
  end

  def self.max_order_date
    max_orders.first.date.to_date
  end

  def self.max_revenue
    max_orders.map { |order| order.order_items.total_price }.sum
  end

  def self.total_revenue
    orders = where("date BETWEEN ? AND ?", DateTime.now.beginning_of_day - 15, DateTime.now.end_of_day)
    orders.map { |order| order.order_items.total_price }.sum
  end
end
