require 'bcrypt'
require 'json'
PATH = 'C:\estudio_ror\Ruby\The_Vault\users.json'
PATH_2 = 'C:\estudio_ror\Ruby\The_Vault\users2.json'
class User
  attr_accessor :username, :password
  def initialize(username,password)
    @username = username
    @password = password
  end
#Crea un usuario
  def self.create_final_hash_user(user)
    user_hash = {
      :username => user.username,
      :password => user.password,
      :secret => []
      }
    return user_hash
  end
end