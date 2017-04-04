class Item < ApplicationRecord
  belongs_to :category
  has_many :line_items, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items

  validates :title, :inventory, :price, presence: true
end
