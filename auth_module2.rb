require 'bcrypt'
require_relative 'storage_manager2'

module Auth
  def self.create_hashed_password(password)
    BCrypt::Password.create(password)
  end

  def self.verify_hashed_password(password)
    BCrypt::Password.new(password)
  end

  def self.verificar_contrasena(username,password)
  hashed_password = StorageManager.find_hashed_password(username)
  verified_hashed_password = self.verify_hashed_password(hashed_password)
  if verified_hashed_password == password
    return true
  else
    return false
  end
  end
end