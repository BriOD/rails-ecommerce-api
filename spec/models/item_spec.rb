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

  describe "instance methods" do 

    before(:each) do 
      @item = create(:item, inventory: 4)
    end

    describe "is_inventory_available?(quantity)" do 

      it "return true when quantity is less than or equal to the item's inventory count" do 
        expect(@item.is_inventory_available?(3)).to eq(true)
      end

      it "returns false when item inventory count is 0 or less than quantity" do 
        expect(@item.is_inventory_available?(10)).to eq(false)
      end
    end

    describe 'update_inventory_count(quantity, type)' do 

      it 'increases the inventory count by the quantity if type is "add"' do
        @item.update_inventory_count(3, 'add')
        expect(@item.inventory).to eq(7)
      end

      it 'reduceses the inventory count by the quantity if type is "remove"' do 
        @item.update_inventory_count(1, 'remove')
        expect(@item.inventory).to eq(3)
      end
    end
  end
end
