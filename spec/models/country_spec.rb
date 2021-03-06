require 'spec_helper'

describe Country do
  it {
    should validate_presence_of :name
    should validate_uniqueness_of :name
    should have_many :states
  }
end
