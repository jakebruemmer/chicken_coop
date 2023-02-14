class CreateCoops < ActiveRecord::Migration[7.0]
  def change
    create_table :coops do |t|
      t.string :name

      t.timestamps
    end
  end
end
