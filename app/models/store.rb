class Store < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  CODE_COUNTRIES = {"AD" => "Europe","AE" => "Asia","AF" => "Asia","AG" => "North America","AI" => "North America","AL" => "Europe","AM" => "Asia","AN" => "North America","AO" => "Africa","AQ" => "Antarctica","AR" => "South America","AS" => "Australia","AT" => "Europe","AU" => "Australia","AW" => "North America","AZ" => "Asia","BA" => "Europe","BB" => "North America","BD" => "Asia","BE" => "Europe","BF" => "Africa","BG" => "Europe","BH" => "Asia","BI" => "Africa","BJ" => "Africa","BM" => "North America","BN" => "Asia","BO" => "South America","BR" => "South America","BS" => "North America",
   "BT" => "Asia","BW" => "Africa","BY" => "Europe","BZ" => "North America","CA" => "North America","CC" => "Asia","CD" => "Africa","CF" => "Africa","CG" => "Africa","CH" => "Europe","CI" => "Africa","CK" => "Australia","CL" => "South America","CM" => "Africa","CN" => "Asia","CO" => "South America","CR" => "North America","CU" => "North America","CV" => "Africa","CX" => "Asia","CY" => "Asia","CZ" => "Europe","DE" => "Europe","DJ" => "Africa","DK" => "Europe","DM" => "North America","DO" => "North America","DZ" => "Africa","EC" => "South America","EE" => "Europe","EG" => "Africa",
   "EH" => "Africa","ER" => "Africa","ES" => "Europe","ET" => "Africa","FI" => "Europe","FJ" => "Australia","FK" => "South America","FM" => "Australia","FO" => "Europe","FR" => "Europe","GA" => "Africa","GB" => "Europe","GD" => "North America","GE" => "Asia","GF" => "South America","GG" => "Europe","GH" => "Africa","GI" => "Europe","GL" => "North America","GM" => "Africa","GN" => "Africa","GP" => "North America","GQ" => "Africa","GR" => "Europe","GS" => "Antarctica","GT" => "North America","GU" => "Australia","GW" => "Africa","GY" => "South America","HK" => "Asia","HN" => "North America",
   "HR" => "Europe","HT" => "North America","HU" => "Europe","ID" => "Asia","IE" => "Europe","IL" => "Asia","IM" => "Europe","IN" => "Asia","IO" => "Asia","IQ" => "Asia","IR" => "Asia","IS" => "Europe","IT" => "Europe","JE" => "Europe","JM" => "North America","JO" => "Asia","JP" => "Asia","KE" => "Africa","KG" => "Asia","KH" => "Asia","KI" => "Australia","KM" => "Africa","KN" => "North America","KP" => "Asia","KR" => "Asia","KW" => "Asia","KY" => "North America","KZ" => "Asia","LA" => "Asia","LB" => "Asia","LC" => "North America","LI" => "Europe","LK" => "Asia","LR" => "Africa","LS" => "Africa",
   "LT" => "Europe","LU" => "Europe","LV" => "Europe","LY" => "Africa","MA" => "Africa","MC" => "Europe","MD" => "Europe","ME" => "Europe","MG" => "Africa","MH" => "Australia","MK" => "Europe","ML" => "Africa","MM" => "Asia","MN" => "Asia","MO" => "Asia","MP" => "Australia","MQ" => "North America","MR" => "Africa","MS" => "North America","MT" => "Europe","MU" => "Africa","MV" => "Asia","MW" => "Africa","MX" => "North America","MY" => "Asia","MZ" => "Africa","NA" => "Africa","NC" => "Australia","NE" => "Africa","NF" => "Australia","NG" => "Africa","NI" => "North America","NL" => "Europe",
   "NO" => "Europe","NP" => "Asia","NR" => "Australia","NU" => "Australia","NZ" => "Australia","OM" => "Asia","PA" => "North America","PE" => "South America","PF" => "Australia","PG" => "Australia","PH" => "Asia","PK" => "Asia","PL" => "Europe","PM" => "North America","PN" => "Australia","PR" => "North America","PS" => "Asia","PT" => "Europe","PW" => "Australia","PY" => "South America","QA" => "Asia","RE" => "Africa","RO" => "Europe","RS" => "Europe","RU" => "Europe","RW" => "Africa","SA" => "Asia","SB" => "Australia","SC" => "Africa","SD" => "Africa","SE" => "Europe","SG" => "Asia",
   "SH" => "Africa","SI" => "Europe","SJ" => "Europe","SK" => "Europe","SL" => "Africa","SM" => "Europe","SN" => "Africa","SO" => "Africa","SR" => "South America","ST" => "Africa","SV" => "North America","SY" => "Asia","SZ" => "Africa","TC" => "North America","TD" => "Africa","TF" => "Antarctica","TG" => "Africa","TH" => "Asia","TJ" => "Asia","TK" => "Australia","TM" => "Asia","TN" => "Africa","TO" => "Australia","TR" => "Asia","TT" => "North America","TV" => "Australia","TW" => "Asia","TZ" => "Africa","UA" => "Europe","UG" => "Africa","US" => "North America","UY" => "South America",
   "UZ" => "Asia","VC" => "North America","VE" => "South America","VG" => "North America","VI" => "North America","VN" => "Asia","VU" => "Australia","WF" => "Australia","WS" => "Australia","YE" => "Asia","YT" => "Africa","ZA" => "Africa","ZM" => "Africa","ZW" => "Africa"}

  # Associations
  belongs_to :user
  has_many :products, :dependent => :destroy
  has_and_belongs_to_many :styles
  has_and_belongs_to_many :designers

  # Validations

  validates_presence_of :name, :owner_name, :country, :state, :city, :description
  validates_length_of :description, :minimum => 100, :maximum => 1000
  validates_uniqueness_of :name
  validate :has_styles?


  # Callbacks
  before_save :set_or_update_slug
  before_destroy { styles.clear }
  before_destroy { designers.clear }



  # Attachments
  has_attached_file :image, heroku: true
  
  # Taggings
  acts_as_taggable_on :tags  
  
  # Scopes
  scope :sorted, lambda { |sort_by = nil| order('name asc') }
  scope :active, where(:active => true)
  scope :featured, where(:featured => true)

  #searchable do
  #  text :name
  #  text :owner_name
  #  integer :designer_ids, :multiple => true do
  #    designers.map(&:id)
  #  end
  #  string :letters, :multiple => true do
  #    designers.map(&:name).map{|letter| letter.first.capitalize}
  #  end
  #  #integer :season_ids, :multiple => true do
  #  #
  #  #end
  #  integer :style_ids, :multiple => true do
  #    styles.map(&:id)
  #  end
  #  string :trends, :multiple => true do
  #    tag_list
  #  end
  #  string :country_continents, :multiple => true do
  #     country_continent = []
  #     country_continent << CODE_COUNTRIES[country] if self.country.present?  # for get the continent
  #     country_continent << country_name if self.country.present? # for get the country
  #  end
  #end

  mapping do
    indexes :name, boost: 10
    indexes :owner_name
    indexes :designer_ids do
       indexes :id, :type => :integer, :index => "not_analyzed"
    end
     indexes :style_ids do
      indexes :id, :type => :integer, :index => "not_analyzed"
    end
    indexes :letters do
       indexes :name, :type => :string, :index => "not_analyzed"
    end
    indexes :trends do
       indexes :name, :type => :string, :index => "not_analyzed"
    end
    indexes :country_continents do
      indexes :id, :type => :string, :index => "not_analyzed"
    end
  end

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: params[:per_page]) do
      query { string params[:search], default_operator: "AND" } if params[:search].present?
      filter :terms, :designer_ids => params[:designer_ids] if params[:designer_ids].present?
      filter :terms, :letters => params[:letters] if params[:letters].present? and !params[:letters].include?("@")
      filter :terms, :style_ids => params[:style_ids] if params[:style_ids].present?
      filter :terms, :trends => params[:trends] if params[:trends].present?
      filter :terms, :country_continents => params[:country_continents] if params[:country_continents].present?
    end
  end

  # self.include_root_in_json = false (necessary before Rails 3.1)
  def to_indexed_json
    to_json(methods: [:designer_ids, :letters, :style_ids, :trends, :country_continents])
  end

  def designer_ids
    designers.map(&:id)
  end

  def letters
    designers.map(&:name).map{|letter| letter.first.capitalize}
  end

  def style_ids
    styles.map(&:id)
  end

  def trends
    tag_list
  end

  def country_continents
    country_continent = []
    country_continent << CODE_COUNTRIES[country] if self.country.present?  # for get the continent
    country_continent << country_name if self.country.present? # for get the country
  end

  def has_styles?
     errors[:base] << "error" "Product must have some styles." if self.styles.blank?
   end


  def country_name
    if self.country
      @country = Carmen::Country.coded(self.country)
      @country.name
    end
  end

  def state_name
    if @country.present?
      @subregion = @country.subregions.coded(self.state)
      @subregion.name
    end
  end

  # Placeholder
  def placeholder_image
    "placeholders/store-#{(self.id % 4) + 1}.jpg"
  end

  private
  def set_or_update_slug
    self.slug = self.name.downcase.gsub(/[^a-zA-Z0-9\s]/, '').gsub(/\s+/, '-')
  end
end
