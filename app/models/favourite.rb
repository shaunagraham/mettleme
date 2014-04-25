class Favourite < ActiveRecord::Base
  # Associations
  belongs_to :user
  
  # Callbacks
  before_save :validate_uniqueness_of_favoured_id_and_type
    
  def favoured
    # 'product' => Product.find(favoured_id)
    # 'store'   => Store.find(favoured_id)
    favoured_type.capitalize.constantize.find(favoured_id)
  end
  
  private
  def validate_uniqueness_of_favoured_id_and_type
    false if self.class.find(:first, conditions: {
            user_id: self.user_id,
        favoured_id: self.favoured_id,
      favoured_type: self.favoured_type
    })
  end
end
