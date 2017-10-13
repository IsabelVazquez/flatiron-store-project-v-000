class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :status
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
