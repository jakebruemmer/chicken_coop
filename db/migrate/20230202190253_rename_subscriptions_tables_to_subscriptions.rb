class RenameSubscriptionsTablesToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    rename_table :subscriptions_tables, :subscriptions
  end
end
