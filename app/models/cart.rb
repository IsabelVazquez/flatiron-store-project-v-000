class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.items.inject(0) {|sum, item| sum + item.price }
  end

  def add_item(item_id)
    item = Item.find(item_id)
    line_item = line_items.detect { |li| li.item == item }
    line_item ||= LineItem.new
    line_item.cart = self
    line_item.item = item
    line_item
  end
end
