require 'json'
class Secret
  attr_accessor :title, :description
  def initialize(title,description)
    @title = title
    @description = description
  end
end
PATH = 'C:\estudio_ror\Ruby\The_Vault_2\users.json'

#se crea un secreto SECRET   OK
nuevo_secreto = Secret.new("contraseña netflix","clavenet123")
#pasamos el secreto a un hash SECRET   OK
secret_hash = {
  :title => nuevo_secreto.title,
  :description => nuevo_secreto.description
}
#buscar el usuario con find, ver sus secretos, si no tiene entregar una lista vacia  ESTO YA EXISTE, ES EL CURRENT USER
file = File.read(PATH)
user_list = JSON.parse(file, {symbolize_names:true})
user = user_list.find { |user| user[:username] == "Bruno" }
puts "Listado de secretos: "
#mostrar secretos  STORAGE MANAGER  OK
user[:secret].each do |secret|
  vuelta = 1
  puts "#{vuelta}. Título: #{secret[:title]}, Contenido: #{secret[:description]}"
  vuelta += 1
end
#agregamos el nuevo secreto al usuario   STORAGE MANAGER
#user[:secret].push(secret_hash)
#json = JSON.pretty_generate(user_list)
#File.write(PATH,json)
#puts user
#se reemplaza la descripcion de un secreto  STORAGE MANAGER
selected_secret = user[:secret].find { |secret| secret[:title] == "contraseña netflix" }

selected_secret[:description] = "contraseña nefli"

#para borrar un secreto  STORAGE MANAGER
puts "antes del delete"
#se elimina el secreto segun el titulo que tenga
user[:secret].delete_if { |secret| secret[:title] == "contraseña netflix" }
#new_hash.each { |k,v| new_hash.delete(k) if v.is_a?(String) }

#puts secret_hash

#puts file

puts user_list

puts user
puts "despues del delete"

#new_hash[:e] = "Bruno"