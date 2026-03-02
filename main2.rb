require_relative 'user2'
require_relative 'auth_module2'
require_relative 'storage_manager2'
require_relative 'menu2'
require_relative 'secret2'

vuelta = 0
puts "Bienvenido a the vault"

while vuelta < 3
  Menu.menu
  user_list = StorageManager.leer_json
  opcion = gets.chomp
  
  case opcion
  when "1"
    print "Usuario: "
    username = gets.chomp
    current_user = StorageManager.find_user(user_list,username)
    if !current_user
      puts "Usuario incorrecto"
      next
    else
      print "Contraseña: "
      password = gets.chomp
      if !Auth.verificar_contrasena(username,password)
        puts "Contraseña incorrecta"
        vuelta +=1
        next
      else
        puts "Credenciales correctas."
        while true
          Menu.secret_menu
          secret_option = gets.chomp
          case secret_option
          when "1"
            puts "Listado de secretos:"
            StorageManager.list_secrets(current_user)
          when "2"
            puts "Ingrese el titulo de su secreto"
            title = gets.chomp
            puts "Ingrese su secreto"
            description = gets.chomp
            new_secret = Secret.new(title,description)
            hashed_new_secret = Secret.create_secret(new_secret)
            current_user = StorageManager.add_new_secret(current_user,hashed_new_secret)
            user_list = StorageManager.update_user(user_list,current_user)
            StorageManager.generar_json(user_list)
            puts "Secreto agregado"
          when "3"
            puts "ingrese el titulo del secreto que quiere modificar: "
            title = gets.chomp
            puts "Ingrese el secreto actualizado: "
            new_description = gets.chomp
            current_user = StorageManager.modify_secret(current_user,title,new_description)
            user_list = StorageManager.update_user(user_list,current_user)
            StorageManager.generar_json(user_list)
          when "4"
            puts "Ingrese el titulo del secreto para eliminar"
            title = gets.chomp
            puts "Seguro que quieres eliminar el secreto: #{title}? Responde si o no"
            answer = gets.chomp
            if answer == "si"
              puts "borrando..."
              current_user = StorageManager.delete_secret(current_user,title)
              user_list = StorageManager.update_user(user_list,current_user)
              StorageManager.generar_json(user_list)
              puts "eliminado con exito"
            else
              next
            end
          when "5"
            break
          end
        end
        
      end
    end
  when "2"
    print "ingrese usuario: "
    username = gets.chomp
    if StorageManager.find_user(user_list,username)
      puts "Usuario ya registrado"
      next
    else
      print "ingrese contraseña: "
      password = gets.chomp
      password = Auth.create_hashed_password(password)
      new_user = User.new(username,password)
      user_hash = User.create_final_hash_user(new_user)
      user_list = StorageManager.add_user_to_list(user_list,user_hash)
      StorageManager.generar_json(user_list)
      puts "Ususario creado"
    end
  when "3"
    break
  else
    puts "Elija una opcion válida"
  end
  
end
puts "Intentos superados, adios"