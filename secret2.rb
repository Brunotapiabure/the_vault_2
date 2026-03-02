require 'json'
class Secret
  attr_accessor :title, :description
  def initialize(title,description)
    @title = title
    @description = description
  end
  def self.create_secret(secret)
    secret_hash = {
      :title => secret.title,
      :description => secret.description
      }
    return secret_hash
  end
end


