class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :client
      t.references :firm
      
      t.date :due_date
      t.date :dated_at
      t.string :payment_condition
      t.string :bank
      t.string :info
      t.integer :bill_number
      t.integer :reference_number
      t.decimal :total_amount
      t.decimal :delay_interest
      
      t.timestamps
    end
  end
end
