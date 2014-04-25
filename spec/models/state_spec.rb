require 'spec_helper'

describe State do
  it {
    should belong_to :country
    should validate_presence_of :name
    should validate_uniqueness_of :name
  }
end
