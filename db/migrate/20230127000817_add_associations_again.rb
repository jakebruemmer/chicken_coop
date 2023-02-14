class AddAssociationsAgain < ActiveRecord::Migration[7.0]
  def change
    change_table :chickens do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
    end

    change_table :coops do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
    end
  end
end
