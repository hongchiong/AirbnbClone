class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.belongs_to :user, index: true, foreign_key: true
      t.text :description
      t.integer :max_guests
      t.integer :price

      t.timestamps null: false
    end
  end
end
