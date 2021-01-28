class Menu < ActiveRecord::Base
  has_many :menu_items

  def self.active
    all.find_by(active: true)
  end
end
