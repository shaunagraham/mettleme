require 'spec_helper'

describe CartItem do
  it {
    should belong_to :cart
    should belong_to :product
    should validate_presence_of :cart
    should validate_presence_of :product
  }
end
