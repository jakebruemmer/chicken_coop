require_relative "20230125211125_create_users"

class RollbackUsers < ActiveRecord::Migration[7.0]
  def change
    revert CreateUsers
  end
end
