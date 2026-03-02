require 'json'
module StorageManager
  PATH = 'C:\estudio_ror\Ruby\The_Vault_2\users.json'

  def self.leer_json
    if !File.exist?(PATH)
      user_list = []
    else
      file = File.read(PATH)
      user_list = JSON.parse(file, {symbolize_names:true})
    end
    return user_list
  end

  def self.generar_json(user_list)
    json = JSON.pretty_generate(user_list)
    File.write(PATH,json)  
  end

  def self.encontrar_usuario(user_list, username)
    if user_list.find { |user| user[:username] == username}
      return true
    else
      return false
    end
  end

  def self.add_user_to_list(user_list,user_hash)
    user_list.push(user_hash)    
    return user_list
  end
  def self.find_hashed_password(username)
    user_list = StorageManager.leer_json
    user = user_list.find { |user| user[:username] == username  }
    return user[:password]
  end
  def self.find_user(user_list,username)
    user = user_list.find { |user| user[:username] == username }
    return user
  end

  def self.list_secrets(current_user)
    count = 1      
    current_user[:secret].each do |secret|
      puts "#{count}. Título: #{secret[:title]}, Contenido: #{secret[:description]}"
      count += 1
    end
  end

  def self.add_new_secret(current_user, secret_hash)
    current_user[:secret].push(secret_hash)
    return current_user
  end

  def self.modify_secret(current_user, title, new_description)
    selected_secret = current_user[:secret].find { |secret| secret[:title] == title }
    selected_secret[:description] = new_description
    return selected_secret
  end

  def self.delete_secret(current_user, title)
    secrets = current_user[:secret]
    secrets.delete_if { |s| s[:title] == title}
    return current_user
  end
  def self.update_user(user_list,current_user)
    user_list.each do |user|
      if user[:username] == current_user[:username]
        user = current_user
      end
    end
    return user_list
  end
end

