class SubCategory < ActiveRecord::Base
  attr_accessible :category_id, :name, :category

  belongs_to :category
  #has_and_belongs_to_many :products
  has_many :products

  validates :name, :category, presence: :true
  validates_uniqueness_of :name
end
