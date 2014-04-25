require 'active_record/secure_id'

class Cart < ActiveRecord::Base
  # Adds secure_id to users
  #
  # Example:
  #
  #   create(:user).secure_id # eg 'a748fd63...'
  #   create(:user).secure_id.length # => 40
  #
  include ActiveRecord::SecureID
  
  # Associations
  #
  # Examples:
  #
  #   cart = create(:cart)
  #   item = create(:cart_item, cart: cart)
  #   
  #   cart.items       # => [item]
  #   cart.products    # => [item.product]
  #   cart.user.class  # => User
  #   
  #   # nil users are OK
  #   create(:cart, user: nil).user # => nil
  #
  has_many :items, class_name: 'CartItem'
  belongs_to :user
      
  # Adds a product to the cart.
  #
  # Example:
  #
  #   cart = Cart.new
  #   cart.items # => [] 
  #   product = create(:prodct) 
  #   cart.add(product)
  #   cart.items # => [product]
  #
  def add(product)
    items.create(product: product)
  end
  
  # Returns the total cost of items in the cart.
  #
  # Example:
  #
  #   cart = Cart.new
  #   5.times { cart.add(create(:product, price: 10)) }
  #   cart.total # => 50
  #
  def total
    total = 0
    items.each do |item|
      total = total + (item.product.price * item.quantity)
    end
    return total
  end
  
  private
  def secure_id_length
    40
  end
end
