FactoryGirl.define do
  factory :order_item do
    quantity 1
    order
    item
  end
end
