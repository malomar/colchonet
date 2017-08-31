class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  
  validates_presence_of :email, :full_name, :location #, :password

  # O has_secure_password cuida de validar as senhas
  #validates_confirmation_of :password
  validates_length_of :bio, minimum: 30, allow_blank: false

  validate :email_format

  has_secure_password

  private
  # Essa validação pode ser representada da seguinte forma:
  # validates_format_of :email, with: EMAIL_REGEXP

  def email_format
    errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
  end
end
