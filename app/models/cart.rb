class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items

  def set_quantity(line_item = nil, item, quantity)
    if line_item 
      quantity_to_update = line_item.quantity + quantity
      item.is_inventory_available?(quantity_to_update) ? quantity_to_update : item.inventory
    else 
      item.is_inventory_available?(quantity) ? quantity : item.inventory 
    end
  end
      
end
