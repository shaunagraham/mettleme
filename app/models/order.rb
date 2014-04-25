class Order < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :cart
end
