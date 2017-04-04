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

    it 'belongs to a user' do 
      order = build(:order)

      expect(order.user).not_to eq(nil)
      expect(order.user.id).not_to eq(nil)
    end

    it 'has many order items'

    it 'has many items through order items'  
    
  end
end
