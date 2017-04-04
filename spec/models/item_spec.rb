require 'rails_helper'

RSpec.describe Item, type: :model do
  
  describe 'validations' do 

    it 'requires a title, inventory count, price and a category' do 
      item = Item.new

      expect(item.valid?).to eq(false) 
      expect(item.errors.full_messages).to eq([
        "Category must exist",
        "Title can't be blank",
        "Inventory can't be blank",
        "Price can't be blank"
      ]) 
    end
  end

  describe 'relationships' do 

    it 'belongs to a category' do 
      item = create(:item)
      
      expect(item.category.title).to eq("clothing")
    end

    it 'has many line items that are destroyed upon deletion of item' do 
      cart = create(:cart)
      item = create(:item)
      line_item = cart.line_items.create(quantity: 1, item: item)

      expect(item.line_items.first.id).not_to eq(nil)

      item.destroy
      line_item = LineItem.find_by(id: line_item.id)
      
      expect(line_item).to eq(nil)
    end

    it 'has many order items' do 
      item = create(:item)
      order = create(:order)
      item.order_items.create(quantity: 1, order: order)
      
      expect(item.order_items.count).to eq(1)
      expect(item.order_items.first.id).not_to eq(nil)
    end
  end
end
