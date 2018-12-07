class User < ApplicationRecord
    before_save { self.email.downcase! } # Callback before saving to database
    
    # Validation
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true,  length: { maximum: 50 }
    
    validates :email, presence: true, length: { maximum: 250 }, 
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password # adds bcrypt secure password hashing
                        # and password and password_confirmation props.
    validates :password, presence: true, length: { minimum: 6 }
end
