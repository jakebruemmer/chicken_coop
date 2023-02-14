class CreateEggs < ActiveRecord::Migration[7.0]
  def change
    create_table :eggs, id: :uuid do |t|
      t.belongs_to :chicken
      t.string :color
      t.date :laid
      t.boolean :fertilized
      t.float :weight_oz
      t.integer :weight_mg

      t.timestamps
    end
  end
end
