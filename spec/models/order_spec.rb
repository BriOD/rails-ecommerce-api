require 'rails_helper'

RSpec.describe Order, type: :model do
  
  describe 'validations' do 

    it "requires a user" do 
      order = Order.new

      expect(order.valid?).to eq(false) 
      expect(order.errors.full_messages).to eq([ "User must exist" ]) 
    end

  end 

  describe 'relationships' do 

    before(:each) do 
      @order = create(:order)
      @item = create(:item)
      @order.order_items.create(quantity: 1, item: @item)
    end

    it 'belongs to a user' do 
      expect(@order.user).not_to eq(nil)
      expect(@order.user.id).not_to eq(nil)
    end

    it 'has many order items' do
      expect(@order.order_items.count).to eq(1)
      expect(@order.order_items.first.id).not_to eq(nil)
    end

    it 'has many items through order items' do
      expect(@order.items.count).to eq(1)
      expect(@order.items.first.id).not_to eq(nil)
    end
  end
end
