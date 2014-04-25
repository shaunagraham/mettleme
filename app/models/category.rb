class Category < ActiveRecord::Base

  # Associations
  has_many :sub_categories
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
end
