class CartItem < ActiveRecord::Base
  # Associations
  belongs_to :cart
  belongs_to :product
  
  # Validations
  validates_presence_of :cart
  validates_presence_of :product
    
  validates :quantity, :presence => true, :numericality => {:greater_than => 0, :message => " is an invalid number."}, :allow_nil => false
end
