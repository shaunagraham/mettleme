class User < ActiveRecord::Base
  include Clearance::User

  #validations
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :password, :presence => true, :confirmation => true, :on => :create, :unless => "authentications.present?"
  validates :password, :confirmation => true, :on => :update, :unless => lambda{ |user| user.password.blank? }
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :admin
  # Associations
  has_one  :store
  has_many :orders
  has_many :products, through: :store
  acts_as_messageable :table_name => "messages", # default 'messages'
                      :required => [:topic, :body, :received_messageable_id],                  # default [:topic, :body]
                      :class_name => "Message",       # default "ActsAsMessageable::Message",
                      :dependent  => :destroy,               # default :nullify
                      :group_messages => true               # default false

  has_many :favourites do
    def find(type, id)
      where(favoured_type: type, favoured_id: id).first
    end
    
    def products
      where(favoured_type: 'product').map(&:favoured)
    end
    
    def stores
      where(favoured_type: 'store').map(&:favoured)      
    end
  end
  
  has_many :authentications, :dependent => :destroy

  
  # Callbacks
  before_save :update_seller_status
  
  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.email = auth_hash["info"]["email"]
      u.authentications<<(authentication)
    end
  end
  
  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  
  def password_optional?
    true
  end
  
  def create_favourite(type, id)
    if favoured = type.to_s.capitalize.constantize.find(id)
      favourites.new(favoured_type: type, favoured_id: id).save
    end
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def self.from_omniauth
    where(auth.slice("provider","uid")).first || create_from_omniauth(auth)    
  end
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.email = auth["info"]["email"]
    end
  end
    
  private
  def update_seller_status
    self.seller = self.paypal_id.present?
    true
  end
end
