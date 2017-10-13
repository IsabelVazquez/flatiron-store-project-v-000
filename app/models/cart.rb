class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.items.inject(0.00) {|sum, item| sum + item.price*(LineItem.find_by(cart_id: self.id).quantity) }
  end

  def add_item(item_id)
    if LineItem.find_by(item_id: item_id, cart_id: self.id)
      something = LineItem.find_by(item_id: item_id, cart_id: self.id)
      something.quantity += 1
      self.line_items << something
    else
      something = LineItem.new(item_id: item_id, cart_id: self.id)
    end
      something
  end

end
