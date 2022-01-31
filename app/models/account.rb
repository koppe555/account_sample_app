class Account
  include ActiveModel::Model

  attr_accessor :id, :user_id, :name, :balance
end