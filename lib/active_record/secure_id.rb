require 'digest/sha1'

module ActiveRecord
  module SecureID
    extend ActiveSupport::Concern
    
    included do
      attr_protected :secure_id
      validates_presence_of :secure_id
      before_validation :create_secure_id, :on => :create
    end
    
    # Stop secure_id from being overriden unless
    # the model hasn't been saved yet, or unless
    # secure_id happens to be blank.
    #
    # @raise RuntimeError
    def secure_id=(string)
      if new_record? || secure_id.blank?
        super
      else
        raise "secure_id cannot be overridden once set"
      end
    end
  
    private
    # Sets a secure_id sixteen characters long, based 
    # on a hash of complex non-guessable data.
    #
    # @return String
    def create_secure_id
      self.secure_id = Digest::SHA1.hexdigest(Time.now.to_s + self.hash.to_s)[0,secure_id_length]
    end
    
    # Default length for secure_id strings; override in models
    # to use shorter/longer secure_ids. Maximum length is 40.
    def secure_id_length
      8
    end
  end
end