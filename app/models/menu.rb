class Menu < ActiveRecord::Base
  has_many :menu_items

  validates :name, presence: true

  def self.active
    all.find_by(active: true)
  end

  def self.set_active(id)
    active_menu = all.active
    if active_menu
      active_menu.active = false
      active_menu.save
    end

    new_menu = find(id)
    new_menu.active = true
    new_menu.save
  end
end
