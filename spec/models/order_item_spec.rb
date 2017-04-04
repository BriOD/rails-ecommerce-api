require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  
  describe 'validations' do 

    it "requires a item, order and quantity" do 
      order_item = OrderItem.new

      expect(order_item.valid?).to eq(false) 
      expect(order_item.errors.full_messages).to eq([
        "Order must exist",
        "Item must exist", 
        "Quantity can't be blank"
      ]) 
    end

  end 

  describe 'relationships' do 

    it 'belongs to an order' do 
      order_item = create(:order_item)
      
      expect(order_item.order).not_to eq(nil)
      expect(order_item.order.id).not_to eq(nil)
    end

    it 'belongs to an item' do 
      order_item = create(:order_item)
      
      expect(order_item.item).not_to eq(nil)
      expect(order_item.item.id).not_to eq(nil)
    end
  end
end