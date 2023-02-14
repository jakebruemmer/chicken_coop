class ChangeSubscriptionToSubscriptionTypeOnUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.rename :subscription, :subscription_type
    end
  end
end
