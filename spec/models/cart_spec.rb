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

    before(:each) do 
      @cart = create(:cart)
      @item = create(:item, inventory: 4)
    end

    describe 'set_quantity(line_item = nil, item, quantity)' do 

      it "doesn't exceed the available inventory count of the item" do 
        line_item = LineItem.create(cart: @cart, item: @item, quantity: 1) 

        expect(@cart.set_quantity(line_item, @item, 5)).to eq(4)
      end

      it "returns the adjusted quantity of an exisiting line item" do 
        line_item = LineItem.create(cart: @cart, item: @item, quantity: 1) 

        expect(@cart.set_quantity(line_item, @item, 1)).to eq(2)
      end

      it "returns the quantity passed as an argument when line_item is nil and item inventory is available" do 
        expect(@cart.set_quantity(nil, @item, 3)).to eq(3)
      end

      it "doesn't exceed the available inventory count of the item when a line_item is not passed as an argument" do 
        expect(@cart.set_quantity(nil, @item, 5)).to eq(4)
      end

    end

    describe 'add_item(item, quantity)' do 

      it 'adds an item to the cart' do 
        @cart.add_item(@item, 2)

        expect(@cart.line_items.first.quantity).to eq(2)
      end

      it 'updates the quantity if an item already exists in the cart' do 
        @cart.add_item(@item, 2)
        @cart.add_item(@item, 1)

        expect(@cart.line_items.count).to eq(1)
        expect(@cart.line_items.first.quantity).to eq(3)
      end

      it 'does not update the quantity if quanity is greater than item inventory count' do 
        @cart.add_item(@item, 8)

        expect(@cart.line_items.first.quantity).to eq(4)
      end

      it "does not add the item if the item's inventory count is 0" do 

      end
    end 

    describe 'total' do 

      it "calculates the price of the cart's items" do 
        item1 = build(:item, price: "10.99")
        item2 = build(:item, price: "10.99")
        item3 = build(:item, price: "11.99")
        @cart.items << item1
        @cart.items << item2 

        expect(@cart.total).to eq(21.98)

        @cart.items << item3
        expect(@cart.total).to eq(33.97)
     end

    end

    describe "checkout" do 

      it "clears out the cart and creates an order with the carts items" 

      it "also updates the item inventory count" 

    end
  end
end
