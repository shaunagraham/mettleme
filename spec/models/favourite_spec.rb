require 'spec_helper'

describe Favourite do
  it {
    should belong_to :user
  }
end
