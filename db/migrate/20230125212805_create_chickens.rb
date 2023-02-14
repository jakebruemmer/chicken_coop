class CreateChickens < ActiveRecord::Migration[7.0]
  def change
    create_table :chickens do |t|
      t.string :name
      t.string :breed
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end
end
