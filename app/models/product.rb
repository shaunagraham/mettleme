class Product < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  # attr_accessible :title, :body

  # Settings for will_paginate
  self.per_page = 30

  # Associations
  belongs_to :store

  has_and_belongs_to_many :seasons
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :colors
  has_and_belongs_to_many :styles

  before_destroy { seasons.clear }
  before_destroy { materials.clear }
  before_destroy { colors.clear }
  before_destroy { styles.clear }


  belongs_to :sub_category


  # Validations
  validates_presence_of :name, :store, :sub_category_id, :price
  validates :gender, :presence => true, :inclusion => { :in => %w(women men both) }

  validate :has_materials?
  validate :has_colors?
  validate :has_seasons?


  # Callbacks
  before_save :set_or_update_slug

  # Tagging
  #acts_as_taggable_on :materials
  #acts_as_taggable_on :colors
  #acts_as_taggable_on :styles

  acts_as_taggable_on :tags
  acts_as_taggable_on :trends

  # Scopes
  scope :sorted, lambda { |sort_by = nil| order(Product.orderer(sort_by)) }
  scope :recent, lambda { |params| filter(params[:filter]).sorted(params[:sort_by])}
  scope :filter, lambda { |params| scoped }

  class << self
    def orderer(sort_by)
      case sort_by
      when 'new', nil
        'created_at desc'
      when 'low-price'
        'price asc'
      when 'high-price'
        'price desc'
      end
    end
  end

  #searchable do
  #  text :name
  #  text :store do
  #    store.name
  #  end
  #  string :gender
  #  integer :sub_category_ids do
  #    sub_category.id if sub_category.present?
  #  end
  #  integer :season_ids, :multiple => true do
  #    seasons.map(&:id)
  #  end
  #  integer :color_ids, :multiple => true do
  #    colors.map(&:id)
  #  end
  #  integer :price
  #  integer :featured_store_ids do
  #     store.id
  #  end
  #end

  mapping do
    indexes :name, boost: 10
    indexes :store_name # analyzer: 'snowball'
    indexes :season_ids do
      indexes :id, :type => :integer, :index => "not_analyzed"
    end
    indexes :sub_category_ids do
       indexes :id, :type => :integer, :index => "not_analyzed"
    end
    indexes :color_ids do
      indexes :id, :type => :integer, :index => "not_analyzed"
    end
    indexes :featured_store_ids do
       indexes :id, :type => :integer, :index => "not_analyzed"
    end
  end

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: params[:per_page]) do
      query { string params[:search], default_operator: "AND" } if params[:search].present?
      filter :term, gender: params[:gender] if params[:gender].present? and params[:gender] != 'both'
      filter :term, price: params[:price] if params[:price].present?
      filter :terms, :season_ids => params[:season_ids] if params[:season_ids].present?
      filter :terms, :sub_category_ids => params[:sub_category_ids] if params[:sub_category_ids].present?
      filter :terms, :color_ids => params[:color_ids] if params[:color_ids].present?
      filter :range, :price => {:gte => params[:start_price], :lte => params[:end_price] } if params[:start_price].present? && params[:end_price].present?
      filter :terms, :featured_store_ids => params[:featured_store_ids] if params[:featured_store_ids].present?
    end
  end

  # self.include_root_in_json = false (necessary before Rails 3.1)
  def to_indexed_json
    to_json(methods: [:season_ids, :store_name, :sub_category_ids, :color_ids, :featured_store_ids])
  end

  def store_name
    store.name
  end

  def season_ids
    seasons.map(&:id)
  end

  def sub_category_ids
    sub_category.id if sub_category.present?
  end

  def color_ids
   colors.map(&:id)
  end

  def featured_store_ids
    store.id
  end

  def has_materials?
    errors[:base] << "error" "Product must have some materials." if self.colors.blank?
  end

  def has_colors?
    errors[:base] << "error" "Product must have some colors." if self.materials.blank?
  end

  def has_seasons?
    errors[:base] << "error" "Product must have some seasons." if self.seasons.blank?
  end

  def product_gender
     self.gender.to_s
  end

  def category
    sub_category.category if sub_category.present?
  end

  # Placeholder
  def image
    "placeholders/product-#{(self.id % 4) + 1}.jpg"    
  end  
  
  private
  def set_or_update_slug
    self.slug = self.name.downcase.gsub(/[^a-zA-Z0-9\s]/, '').gsub(/\s+/, '-')
  end  
end
