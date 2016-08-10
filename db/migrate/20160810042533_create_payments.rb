class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|

    	t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :booking, index: true, foreign_key: true
      t.integer :paid
      t.integer :transaction_id
      
      t.timestamps null: false
    end
  end
end
