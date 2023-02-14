class IdToUuid < ActiveRecord::Migration[7.0]
  def change
    # Chickens
    add_column :chickens, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :chickens do |t|
      t.remove :id
      t.remove :user_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE chickens ADD PRIMARY KEY (id);"

    # Coops
    add_column :coops, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :coops do |t|
      t.remove :id
      t.remove :user_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE coops ADD PRIMARY KEY (id);"

    # Users
    add_column :users, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :users do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
