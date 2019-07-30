class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :account_number
      t.string :contact
      t.string :bank_name
      t.timestamps
    end
  end
end
