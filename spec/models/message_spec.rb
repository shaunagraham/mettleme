require 'spec_helper'

describe Message do
  it {
    should belong_to :sender
    should have_and_belong_to_many :recipients
  }
end
