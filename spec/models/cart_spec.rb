require 'rails_helper'

RSpec.describe Cart, type: :model do
  
  describe 'validations' do 

    it 'requires a user upon creation' do 
      cart = build(:cart, user: nil)

      expect(cart.valid?).to eq(false)
      expect(cart.errors.full_messages).to eq(["User must exist"])
    end
  end 

  describe 'relationships' do 

    it 'has many line items that are destroyed upon deletion of cart' do 
      cart = create(:cart)
      item = create(:item)
      line_item = cart.line_items.create(quantity: 1, item: item)

      expect(cart.line_items.first.id).not_to eq(nil)

      cart.destroy
      line_item = LineItem.find_by(id: line_item.id)
      
      expect(line_item).to eq(nil)
    end

    it 'has many items through line items' do 
      cart = create(:cart)
      item = create(:item)
      line_item = cart.line_items.create(quantity: 1, item: item)

      expect(cart.items.count).to eq(1)
    end

    it 'belongs to a user' do 
      cart = create(:cart)
      
      expect(cart.user.email).to eq("avi@flatironschool.com")
    end
  end

  describe 'instance methods' do 

    describe 'add_an_item' do 

      it 'adds an item to the cart'

    end 

    describe 'total' do 

      it "calculates the price of the cart's items" 

    end

    describe "checkout" do 

      it "clears out the cart and creates an order with the carts items" 

      it "also updates the item inventory count" 

    end
  end
end
