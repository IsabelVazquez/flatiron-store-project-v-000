class CartsController < ApplicationController
  before_action :set_cart

  def show
  end

  def checkout
    @current_cart.line_items.each do |li|
      item = Item.find(li.item_id)
      item.update(inventory: item.inventory - li.quantity)
    end
    @current_cart.status = "Submitted"
    @current_cart.save
    current_user.current_cart = nil
    current_user.save
    redirect_to cart_path(@current_cart)
  end

  private
    def set_cart
      if user_signed_in? && current_user.current_cart != nil
        @current_cart = current_user.current_cart
      end
    end
end
