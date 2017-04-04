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

    it 'belongs to an order' 

    it 'belongs to an item' 
    
  end
end