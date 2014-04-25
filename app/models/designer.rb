class Designer < ActiveRecord::Base
  attr_accessible :name, :last_name, :top
  has_and_belongs_to_many :stores
  validates_presence_of :name, :last_name
  validates :name, :uniqueness => { :scope => :last_name, :message => "Last Name is uniq" }

  scope :top_designers, where(:top => true)
end
