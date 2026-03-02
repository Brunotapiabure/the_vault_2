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
      :password => user.password
      }
    return user_hash
  end
end

#tengo listo el login ctm por fin

#creamos el objeto usuario     --- user OK
nuevo_usuario = User.new("Bruno","Clave1")
#Pasamos el objeto usuario a un hash    --- user OK
user_hash = User.create_final_hash_user(nuevo_usuario)
#Cambiamos la clave por el hash(clave larga)    --- auth  OK
user_hash[:password] = BCrypt::Password.create(user_hash[:password])
#verificar si funciona, se evalua el hash en bcrypt y la contraseña ingresada al otro lado   ---auth OK
puts BCrypt::Password.new("$2a$12$acpGGU3E/9YAzC0ZT79mi.g/KDKBl7zKx0uSFDW.GOT4e0SaZB/lG") == "Clave1"
#si el archivo no existe se crea una lista vacia   ---storagemanger  OK
if !File.exist?(PATH)
  user_list = []
#si el archivo existe se lee y se deja en una lista   ---storagemanger  OK
else
  file = File.read(PATH)
  user_list = JSON.parse(file, {symbolize_names:true})
end
#agregamos el usuario creado a la lista   ---storagemanger OK
user_list.append(user_hash)
#creamos un json nuevo con el nuevo usuario   ---storagemanger OK
json = JSON.pretty_generate(user_list)
#creamos un nuevo archivo con el json nuevo    ---storagemanger  OK
File.write(PATH_2,json)
#encontrar usuario y encontrar password    ---storagemanger  OK
if user_list.find {|user|  user[:username] == "Bruno" && BCrypt::Password.new(user[:password]) == "Clave1" }
  puts "encontrado"
else
  puts "no encontrado"
end 
#esta una funcion
if user_list.find { |user| user[:username] == "Bruno"}
  puts "usuario encontrado"
end
#esta deberia encontrar la otra
if user_list.find { |user| BCrypt::Password.new(user[:password]) == "Clave1"}
  
end

#mostramos la lista con usuarios
#user_list.each { |user| print "Usuario: " + user[:username] + " - " + "Contraseña: " + user[:password] }


