require 'rails_helper'

RSpec.describe LineItem, type: :model do
  
  describe 'validations' do 

    it 'requires a cart, item' do 
      line_item = LineItem.new

      expect(line_item.valid?).to eq(false) 
      expect(line_item.errors.full_messages).to eq([
        "Cart must exist",
        "Item must exist"
      ]) 
    end
  end

  describe 'relationships' do 

    it 'belongs to an item' do 
      line_item = create(:line_item)
      
      expect(line_item.item.title).to eq("Legendary Link Hoodie")
    end

    it 'belongs to a cart' do 
      line_item = create(:line_item)
      
      expect(line_item.cart.id).not_to eq(nil)
    end
  end

  describe 'instance methods' do 
    
    describe 'total' do 

      it "multiplies the quantity of a line item with the item's price" do 
        line_item = create(:line_item, quantity: 3)

        expect(line_item.total).to eq(164.97)
      end
    end
  end
end
