class Chef < ApplicationRecord
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :chefname, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  # we needed to use allow_nil for editing feature. It won't cause any problem while
  # creating new chef because has_secure password always forces password to be not nil while creating
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true

  has_many :recipes
  has_secure_password
end
