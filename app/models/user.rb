class User
  include ActiveModel::Model

  attr_accessor :id, :name

  def generate_user_url
    Settings.api.base_url + "users/#{self.id}"
  end

  def generate_accounts_url
    Settings.api.base_url + "users/#{self.id}" + "/accounts"
  end
end