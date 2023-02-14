class MakeChickenIdOnEggsUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :eggs, :chicken_uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :eggs do |t|
      t.remove :chicken_id
      t.rename :chicken_uuid, :chicken_id
    end
  end    
end
