class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true

  validates :email, uniqueness: true, :email_format => { :message => 'email is invalid' }

end
